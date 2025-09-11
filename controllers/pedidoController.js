import fetch from "node-fetch";
import dotenv from "dotenv";
import { db } from "../config/db.js";
import { tarifas } from "../utils/tarifas.js";
dotenv.config();

const MAPBOX_TOKEN = process.env.MAPBOX_TOKEN;

function normalizeString(str) {
  return str
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .trim()
    .toLowerCase();
}

function calcularTarifa({ zona, municipio, km }) {
  const munNorm = normalizeString(municipio);
  const kmNum = Number(km);
  const zonaNum = Number(zona);

  for (const t of tarifas) {
    if (
      t.municipios &&
      t.municipios.some((m) => normalizeString(m) === munNorm)
    ) {
      if (t.km) {
        if (kmNum >= t.km.inicio && kmNum <= t.km.fin) return t.precio;
      } else {
        return t.precio;
      }
    }
  }

  for (const t of tarifas) {
    if (t.km && kmNum >= t.km.inicio && kmNum <= t.km.fin) {
      if (
        t.municipios &&
        !t.municipios.some((m) => normalizeString(m) === munNorm)
      )
        continue;
      return t.precio;
    }
  }

  for (const t of tarifas) {
    if (t.zonas && t.zonas.includes(zonaNum)) return t.precio;
  }

  return null;
}

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

async function calcularKm(origen, destino) {
  const [lon1, lat1] = await geocodeDireccion(origen);
  const [lon2, lat2] = await geocodeDireccion(destino);

  const url = `https://api.mapbox.com/directions/v5/mapbox/driving/${lon1},${lat1};${lon2},${lat2}?geometries=geojson&access_token=${MAPBOX_TOKEN}`;
  const resp = await fetch(url);
  const data = await resp.json();

  if (!data.routes?.length) throw new Error("No se pudo calcular ruta");
  return data.routes[0].distance / 1000; // km
}

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

    // Insertar dirección origen
    const [origenResult] = await db.query(
      "INSERT INTO direccion (calle_principal, numero, calle_secundaria, zona, colonia_o_barrio, municipio, departamento, codigo_postal, referencias) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
      Object.values(direccion_origen)
    );
    const id_direccion_origen = origenResult.insertId;

    // Insertar dirección destino
    const [destinoResult] = await db.query(
      "INSERT INTO direccion (calle_principal, numero, calle_secundaria, zona, colonia_o_barrio, municipio, departamento, codigo_postal, referencias) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
      Object.values(direccion_destino)
    );
    const id_direccion_destino = destinoResult.insertId;

    // Calcular distancia
    const km_destino = await calcularKm(direccion_origen, direccion_destino);

    // Calcular costo
    const costo = calcularTarifa({
      zona: direccion_destino.zona,
      municipio: direccion_destino.municipio,
      km: km_destino,
    });

    if (!costo) return res.status(400).json({ error: "No se encontró tarifa" });

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
      "INSERT INTO envio (id_pedido, costo, estado) VALUES (?, ?, 'En tránsito')",
      [id_pedido, costo]
    );

    // Redondeos
    const kmRedondeado = Number(km_destino.toFixed(1));
    const costoRedondeado = Number(costo.toFixed(2));

    res.json({
      msg: "Pedido creado",
      id_pedido,
      costo: costoRedondeado,
      km_destino: kmRedondeado,
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
