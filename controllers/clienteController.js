import { db } from "../config/db.js";

// Detalles de un pedido del cliente
export const getPedidoCliente = async (req, res) => {
  try {
    const { id_pedido } = req.params;
    const [rows] = await db.query(
      `SELECT e.id_envio, e.estado, e.costo, e.fecha_asignacion,
              p.id_pedido, pa.descripcion AS paquete, pa.peso, pa.dimensiones, pa.fragil,
              d1.*, d2.*,
              p.nombre_destinatario, p.email_destinatario, p.telefono_destinatario
       FROM envio e
       JOIN pedido p ON e.id_pedido = p.id_pedido
       JOIN paquete pa ON p.id_paquete = pa.id_paquete
       JOIN direccion d1 ON p.id_direccion_origen = d1.id_direccion
       JOIN direccion d2 ON p.id_direccion_destino = d2.id_direccion
       WHERE p.id_pedido = ? AND p.id_usuario = ?`,
      [id_pedido, req.user.id]
    );

    if (!rows.length)
      return res
        .status(404)
        .json({ error: "Pedido no encontrado o no te pertenece" });

    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
// Última ubicación de su pedido
export const getLastPositionCliente = async (req, res) => {
  try {
    const { id_envio } = req.params;

    // Validar que el envío pertenezca al cliente
    const [envio] = await db.query(
      `SELECT e.id_envio 
       FROM envio e
       JOIN pedido p ON e.id_pedido = p.id_pedido
       WHERE e.id_envio = ? AND p.id_usuario = ?`,
      [id_envio, req.user.id]
    );
    if (!envio.length)
      return res
        .status(403)
        .json({ error: "No autorizado para ver este envío" });

    // Traer la última posición
    const [rows] = await db.query(
      `SELECT latitud, longitud, fecha_hora
       FROM tracking_envio
       WHERE id_envio = ?
       ORDER BY fecha_hora DESC
       LIMIT 1`,
      [id_envio]
    );

    res.json(rows[0] || null);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
