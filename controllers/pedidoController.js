import fetch from "node-fetch";
import dotenv from "dotenv";
import { db } from "../config/db.js";
import { tarifas, calcularTarifa } from "../utils/tarifas.js";
dotenv.config();

const MAPBOX_TOKEN = process.env.MAPBOX_TOKEN;

function normalizeString(str) {
  return str
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .trim()
    .toLowerCase();
}

function parseZona(zona) {
  if (typeof zona === "string") {
    const match = zona.match(/\d+/);
    return match ? Number(match[0]) : null;
  }
  return Number(zona);
}

// Función para geocodificar con Mapbox
async function geocodeDireccion(direccion) {
  const query = encodeURIComponent(
    `${direccion.calle_principal} ${direccion.numero}, ${direccion.municipio}, ${direccion.departamento}`
  );
  const url = `https://api.mapbox.com/geocoding/v5/mapbox.places/${query}.json?access_token=${MAPBOX_TOKEN}`;
  const resp = await fetch(url);
  const data = await resp.json();
  if (!data.features?.length)
    throw new Error("No se pudo geocodificar la dirección");
  return data.features[0].geometry.coordinates;
}

// Calcula km usando Mapbox Directions API
async function calcularKm(origen, destino) {
  const [lon1, lat1] = await geocodeDireccion(origen);
  const [lon2, lat2] = await geocodeDireccion(destino);

  const url = `https://api.mapbox.com/directions/v5/mapbox/driving/${lon1},${lat1};${lon2},${lat2}?geometries=geojson&access_token=${MAPBOX_TOKEN}`;
  const resp = await fetch(url);
  const data = await resp.json();

  if (!data.routes?.length) throw new Error("No se pudo calcular ruta");
  return data.routes[0].distance / 1000; // km
}

// 🔹 Solo calcula costo, no guarda nada
export const calcularCostoPedido = async (req, res) => {
  try {
    const { paquete, direccion_origen, direccion_destino } = req.body;

    const km_destino = await calcularKm(direccion_origen, direccion_destino);
    const zonaNum = parseZona(direccion_destino.zona);

    const costo = calcularTarifa({
      zona: zonaNum,
      municipio: direccion_destino.municipio,
      km: km_destino,
    });

    if (!costo)
      return res.status(400).json({
        error: "No se encontró tarifa para la ruta indicada.",
      });

    res.json({
      km_destino: Number(km_destino.toFixed(1)),
      costo: Number(costo.toFixed(2)),
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// 🔹 Crear pedido real
export const createPedido = async (req, res) => {
  try {
    const { paquete, direccion_origen, direccion_destino, destinatario } =
      req.body;

    // Insertar paquete
    const [paqueteResult] = await db.query(
      "INSERT INTO paquete (descripcion, peso, dimensiones, fragil) VALUES (?, ?, ?, ?)",
      [
        paquete.descripcion,
        paquete.peso,
        paquete.dimensiones,
        paquete.fragil ? 1 : 0,
      ]
    );
    const id_paquete = paqueteResult.insertId;

    // Insertar direcciones
    const [origenResult] = await db.query(
      "INSERT INTO direccion (calle_principal, numero, calle_secundaria, zona, colonia_o_barrio, municipio, departamento, codigo_postal, referencias) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
      Object.values(direccion_origen)
    );
    const id_direccion_origen = origenResult.insertId;

    const [destinoResult] = await db.query(
      "INSERT INTO direccion (calle_principal, numero, calle_secundaria, zona, colonia_o_barrio, municipio, departamento, codigo_postal, referencias) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
      Object.values(direccion_destino)
    );
    const id_direccion_destino = destinoResult.insertId;

    // Calcular distancia y costo
    const km_destino = await calcularKm(direccion_origen, direccion_destino);
    const zonaNum = parseZona(direccion_destino.zona);
    const costo = calcularTarifa({
      zona: zonaNum,
      municipio: direccion_destino.municipio,
      km: km_destino,
    });

    if (!costo)
      return res.status(400).json({
        error: "No se encontró tarifa para la ruta indicada.",
      });

    // Repartidor disponible
    const [repartidores] = await db.query(
      `SELECT rz.id_repartidor, COUNT(e.id_envio) AS carga
       FROM repartidor_zona rz
       LEFT JOIN envio e 
         ON e.id_repartidor = rz.id_repartidor
         AND e.estado != 'Entregado'
       WHERE rz.municipio = ? AND rz.zona = ?
       GROUP BY rz.id_repartidor
       ORDER BY carga ASC
       LIMIT 1`,
      [direccion_destino.municipio, zonaNum]
    );

    if (!repartidores.length) {
      return res.status(400).json({
        error:
          "Lo sentimos, actualmente no hay repartidores disponibles en tu zona. Intenta más tarde o cambia la dirección.",
      });
    }

    const id_repartidor = repartidores[0].id_repartidor;

    // Insertar pedido
    const [pedidoResult] = await db.query(
      "INSERT INTO pedido (id_usuario, id_paquete, id_direccion_origen, id_direccion_destino, nombre_destinatario, email_destinatario, telefono_destinatario) VALUES (?, ?, ?, ?, ?, ?, ?)",
      [
        req.user.id,
        id_paquete,
        id_direccion_origen,
        id_direccion_destino,
        destinatario.nombre,
        destinatario.email,
        destinatario.telefono,
      ]
    );
    const id_pedido = pedidoResult.insertId;

    // Insertar envío
    await db.query(
      "INSERT INTO envio (id_pedido, id_repartidor, costo, estado) VALUES (?, ?, ?, 'En tránsito')",
      [id_pedido, id_repartidor, costo]
    );

    res.json({
      msg: "Pedido creado",
      id_pedido,
      id_repartidor,
      costo: Number(costo.toFixed(2)),
      km_destino: Number(km_destino.toFixed(1)),
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Ver pedidos del usuario
export const getMisPedidos = async (req, res) => {
  try {
    const [rows] = await db.query(
      `SELECT 
         p.id_pedido,
         e.id_envio,
         e.estado,
         e.costo,
         e.fecha_asignacion,
         pa.descripcion AS paquete,
         d1.municipio AS origen,
         d2.municipio AS destino
       FROM pedido p
       JOIN envio e ON p.id_pedido = e.id_pedido
       JOIN paquete pa ON p.id_paquete = pa.id_paquete
       JOIN direccion d1 ON p.id_direccion_origen = d1.id_direccion
       JOIN direccion d2 ON p.id_direccion_destino = d2.id_direccion
       WHERE p.id_usuario = ?`,
      [req.user.id]
    );

    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
