import { db } from "../config/db.js";
import { hashPassword, comparePassword } from "../utils/hash.js";
import fetch from "node-fetch";
import { transporter } from "../config/email.js"; 
import { generateToken } from "../config/jwt.js";
import { generateGuestToken } from "../config/jwt.js";
// ---------------- PERFIL ----------------
export const getProfile = async (req, res) => {
  try {
    const [rows] = await db.query(
      "SELECT id_usuario, nombre, telefono, email FROM usuario WHERE id_usuario = ?",
      [req.user.id]
    );
    if (!rows.length) return res.status(404).json({ error: "No encontrado" });
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export const updateProfile = async (req, res) => {
  try {
    const { nombre, telefono, email } = req.body;
    await db.query(
      "UPDATE usuario SET nombre = ?, telefono = ?, email = ? WHERE id_usuario = ?",
      [nombre, telefono, email, req.user.id]
    );
    res.json({ msg: "Perfil actualizado" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export const changePassword = async (req, res) => {
  try {
    const { currentPassword, newPassword } = req.body;
    const [rows] = await db.query(
      "SELECT password FROM usuario WHERE id_usuario = ?",
      [req.user.id]
    );
    if (!rows.length)
      return res.status(404).json({ error: "Usuario no encontrado" });

    const valid = await comparePassword(currentPassword, rows[0].password);
    if (!valid) return res.status(400).json({ error: "Contraseña incorrecta" });

    const hashed = await hashPassword(newPassword);
    await db.query("UPDATE usuario SET password = ? WHERE id_usuario = ?", [
      hashed,
      req.user.id,
    ]);
    res.json({ msg: "Contraseña actualizada" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// ---------------- PEDIDOS ----------------
export const getAssignedPedidos = async (req, res) => {
  try {
    const [rows] = await db.query(
      `SELECT e.id_envio, e.estado, e.costo, e.fecha_asignacion,
              p.id_pedido, pa.descripcion AS paquete, pa.peso, pa.dimensiones, pa.fragil,
              
              -- Dirección origen
              d1.calle_principal AS origen_calle,
              d1.numero AS origen_numero,
              d1.calle_secundaria AS origen_secundaria,
              d1.colonia_o_barrio AS origen_colonia,
              d1.zona AS origen_zona,
              d1.municipio AS origen_municipio,
              d1.departamento AS origen_departamento,
              d1.codigo_postal AS origen_cp,
              
              -- Dirección destino
              d2.calle_principal AS destino_calle,
              d2.numero AS destino_numero,
              d2.calle_secundaria AS destino_secundaria,
              d2.colonia_o_barrio AS destino_colonia,
              d2.zona AS destino_zona,
              d2.municipio AS destino_municipio,
              d2.departamento AS destino_departamento,
              d2.codigo_postal AS destino_cp,
              
              p.nombre_destinatario, p.email_destinatario, p.telefono_destinatario
       FROM envio e
       JOIN pedido p ON e.id_pedido = p.id_pedido
       JOIN paquete pa ON p.id_paquete = pa.id_paquete
       JOIN direccion d1 ON p.id_direccion_origen = d1.id_direccion
       JOIN direccion d2 ON p.id_direccion_destino = d2.id_direccion
       WHERE e.id_repartidor = ? AND e.estado != 'Entregado'`,
      [req.user.id]
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export const getHistorialPedidos = async (req, res) => {
  try {
    const [rows] = await db.query(
      `SELECT e.id_envio, e.estado, e.costo, e.fecha_asignacion,
              p.id_pedido, pa.descripcion AS paquete, pa.peso, pa.dimensiones, pa.fragil,
              
              -- Dirección origen
              d1.calle_principal AS origen_calle,
              d1.numero AS origen_numero,
              d1.calle_secundaria AS origen_secundaria,
              d1.colonia_o_barrio AS origen_colonia,
              d1.zona AS origen_zona,
              d1.municipio AS origen_municipio,
              d1.departamento AS origen_departamento,
              d1.codigo_postal AS origen_cp,
              
              -- Dirección destino
              d2.calle_principal AS destino_calle,
              d2.numero AS destino_numero,
              d2.calle_secundaria AS destino_secundaria,
              d2.colonia_o_barrio AS destino_colonia,
              d2.zona AS destino_zona,
              d2.municipio AS destino_municipio,
              d2.departamento AS destino_departamento,
              d2.codigo_postal AS destino_cp,
              
              p.nombre_destinatario, p.email_destinatario, p.telefono_destinatario
       FROM envio e
       JOIN pedido p ON e.id_pedido = p.id_pedido
       JOIN paquete pa ON p.id_paquete = pa.id_paquete
       JOIN direccion d1 ON p.id_direccion_origen = d1.id_direccion
       JOIN direccion d2 ON p.id_direccion_destino = d2.id_direccion
       WHERE e.id_repartidor = ? AND e.estado = 'Entregado'`,
      [req.user.id]
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// ---------------- TRACKING ----------------
export const savePosition = async (req, res) => {
  try {
    const { id_envio } = req.params;
    const { latitud, longitud } = req.body;

    await db.query(
      "INSERT INTO tracking_envio (id_envio, latitud, longitud, fecha_hora) VALUES (?, ?, ?, NOW())",
      [id_envio, latitud, longitud]
    );
    res.json({ msg: "Posición guardada" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export const getLastPosition = async (req, res) => {
  try {
    const { id_envio } = req.params;

    // Primero valida que este envío le pertenece al repartidor autenticado
    const [check] = await db.query(
      "SELECT id_envio FROM envio WHERE id_envio = ? AND id_repartidor = ?",
      [id_envio, req.user.id]
    );

    if (check.length === 0) {
      return res.status(403).json({ error: "No autorizado" });
    }

    // Ahora sí trae la última posición
    const [rows] = await db.query(
      `SELECT latitud, longitud, fecha_hora 
       FROM tracking_envio 
       WHERE id_envio = ? 
       ORDER BY fecha_hora DESC 
       LIMIT 1`,
      [id_envio]
    );

    if (rows.length === 0) {
      return res.status(404).json({ error: "No hay posiciones registradas" });
    }

    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// ---------------- ESTADO ----------------
export const marcarRecolectado = async (req, res) => {
  try {
    const { id_envio } = req.params;

    // 1. Actualizar estado
    await db.query(
      "UPDATE envio SET estado = 'Recolectado' WHERE id_envio = ? AND id_repartidor = ?",
      [id_envio, req.user.id]
    );

    // 2. Obtener email del cliente
    const [rows] = await db.query(
      `SELECT u.email, u.nombre AS nombre_usuario, p.nombre_destinatario
       FROM envio e
       JOIN pedido p ON e.id_pedido = p.id_pedido
       JOIN usuario u ON p.id_usuario = u.id_usuario
       WHERE e.id_envio = ?`,
      [id_envio]
    );

    if (rows.length) {
      const cliente = rows[0];

      // 3. Enviar correo con Nodemailer
      await transporter.sendMail({
        from: `"FastBox" <fastboxteam@gmail.com>`,
        to: cliente.email,
        subject: "Tu pedido ha sido recolectado",
        html: `<h1>Hola ${cliente.nombre_destinatario}!</h1>
               <p>Tu pedido esta siendo<strong>recolectado</strong> por nuestro repartidor y pronto estará en camino.</p>`,
        text: `Hola ${cliente.nombre_destinatario}! Tu pedido esta siendo recolectado por nuestro repartidor y pronto estará en camino.`,
      });
    }

    res.json({ msg: "Estado cambiado a Recolectado y correo enviado" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

/*
export const marcarEntregado = async (req, res) => {
  try {
    const { id_envio } = req.params;

    await db.query(
      "UPDATE envio SET estado = 'Entregado' WHERE id_envio = ? AND id_repartidor = ?",
      [id_envio, req.user.id]
    );

    const [rows] = await db.query(
      `SELECT p.nombre_destinatario, p.email_destinatario
       FROM envio e
       JOIN pedido p ON e.id_pedido = p.id_pedido
       WHERE e.id_envio = ?`,
      [id_envio]
    );

    if (rows.length) {
      const destinatario = rows[0];

      // Crear token guest
      const guestToken = generateToken(
        { id_envio, guest: true },
        "2h"
      );

      const trackingUrl = `http://localhost:4200/guest-tracking/${guestToken}`;

      await transporter.sendMail({
        from: `"FastBox" <fastboxteam@gmail.com>`,
        to: destinatario.email_destinatario,
        subject: "¡Tu paquete ha sido entregado!",
        html: `
          <h2>Hola ${destinatario.nombre_destinatario} 👋</h2>
          <p>Tu paquete ha sido entregado. 
          Puedes ver el recorrido en este enlace (válido por 2 horas):</p>
          <a href="${trackingUrl}" style="background:#2563eb;color:white;padding:10px 15px;text-decoration:none;border-radius:5px;">
             Ver tracking
          </a>
        `,
        text: `Hola ${destinatario.nombre_destinatario}, tu paquete ha sido entregado. Mira el recorrido aquí: ${trackingUrl}`,
      });
    }

    res.json({ msg: "Estado cambiado a Entregado y correo enviado con link de tracking" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: err.message });
  }
};
*/

export const marcarEntregado = async (req, res) => {
  try {
    const { id_envio } = req.params;

    // 1. Actualizar estado
    await db.query(
      "UPDATE envio SET estado = 'Entregado' WHERE id_envio = ? AND id_repartidor = ?",
      [id_envio, req.user.id]
    );

    // 2. Obtener datos del destinatario
    const [rows] = await db.query(
      `SELECT p.nombre_destinatario, p.email_destinatario
       FROM envio e
       JOIN pedido p ON e.id_pedido = p.id_pedido
       WHERE e.id_envio = ?`,
      [id_envio]
    );

    if (rows.length) {
      const destinatario = rows[0];

      // 3. Crear token guest válido por 24h
      const guestToken = generateGuestToken(id_envio);

      const trackingUrl = `http://localhost:4200/guest-tracking/${guestToken}`;

      // 4. Enviar correo con link de tracking
      await transporter.sendMail({
        from: `"FastBox" <fastboxteam@gmail.com>`,
        to: destinatario.email_destinatario,
        subject: "¡Tu paquete está en camino!",
        html: `
          <h2>Hola ${destinatario.nombre_destinatario} 👋</h2>
          <p>Tu paquete está en camino. Puedes seguir la ubicación en tiempo real aquí:</p>
          <a href="${trackingUrl}" style="background:#16a34a;color:white;padding:10px 15px;text-decoration:none;border-radius:5px;">
             Seguir mi paquete
          </a>
        `,
        text: `Hola ${destinatario.nombre_destinatario}, tu paquete está en camino. Sigue el tracking aquí: ${trackingUrl}`,
      });
    }

    res.json({ msg: "Estado cambiado a 'Entregado' y correo enviado con link de tracking" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: err.message });
  }
};



