import { db } from "../config/db.js";
import { tarifas } from "../utils/tarifas.js";

// Función corregida: municipio+km > km > zona
function calcularTarifa({ zona, municipio, km }) {
  // 1️⃣ Tarifas con municipio + km
  for (const t of tarifas) {
    if (t.municipios && t.municipios.includes(municipio)) {
      if (t.km) {
        if (km >= t.km.inicio && km <= t.km.fin) return t.precio;
      } else {
        return t.precio;
      }
    }
  }

  // 2️⃣ Tarifas basadas solo en km
  for (const t of tarifas) {
    if (t.km && km >= t.km.inicio && km <= t.km.fin) {
      if (t.municipios && !t.municipios.includes(municipio)) continue;
      return t.precio;
    }
  }

  // 3️⃣ Tarifas basadas solo en zona
  for (const t of tarifas) {
    if (t.zonas && t.zonas.includes(Number(zona))) return t.precio;
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

    // 4️⃣ Calcular costo (municipio+km > km > zona)
    const costo = calcularTarifa({
      zona: parseInt(direccion_destino.zona),
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
