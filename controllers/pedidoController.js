import { db } from "../config/db.js";
import { tarifas } from "../utils/tarifas.js";

// Normaliza strings: quita acentos y pasa a minúsculas
function normalizeString(str) {
  return str
    .normalize("NFD") // separa acentos
    .replace(/[\u0300-\u036f]/g, "") // quita acentos
    .trim()
    .toLowerCase();
}

// Función robusta: municipio+km > km > zona
function calcularTarifa({ zona, municipio, km }) {
  const munNorm = normalizeString(municipio);
  const kmNum = Number(km);
  const zonaNum = Number(zona);

  // 1️⃣ Municipio + km
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

  // 2️⃣ Solo km
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

  // 3️⃣ Solo zona
  for (const t of tarifas) {
    if (t.zonas && t.zonas.includes(zonaNum)) return t.precio;
  }

  return null;
}

export const createPedido = async (req, res) => {
  try {
    const {
      paquete,
      direccion_origen,
      direccion_destino,
      destinatario,
      km_destino,
    } = req.body;

    // 1️⃣ Insertar paquete
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

    // 2️⃣ Insertar dirección origen
    const [origenResult] = await db.query(
      "INSERT INTO direccion (calle_principal, numero, calle_secundaria, zona, colonia_o_barrio, municipio, departamento, codigo_postal, referencias) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
      Object.values(direccion_origen)
    );
    const id_direccion_origen = origenResult.insertId;

    // 3️⃣ Insertar dirección destino
    const [destinoResult] = await db.query(
      "INSERT INTO direccion (calle_principal, numero, calle_secundaria, zona, colonia_o_barrio, municipio, departamento, codigo_postal, referencias) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
      Object.values(direccion_destino)
    );
    const id_direccion_destino = destinoResult.insertId;

    // 4️⃣ Calcular costo
    const costo = calcularTarifa({
      zona: direccion_destino.zona,
      municipio: direccion_destino.municipio,
      km: km_destino,
    });

    if (!costo) return res.status(400).json({ error: "No se encontró tarifa" });

    // 5️⃣ Insertar pedido
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

    // 6️⃣ Insertar envío
    await db.query(
      "INSERT INTO envio (id_pedido, costo, estado) VALUES (?, ?, 'En tránsito')",
      [id_pedido, costo]
    );

    res.json({ msg: "Pedido creado", id_pedido, costo });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
