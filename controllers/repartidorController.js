import { db } from "../config/db.js";

// Ver perfil repartidor (igual que usuario)
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

// Actualizar perfil
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

// Cambiar contraseña
import { hashPassword, comparePassword } from "../utils/hash.js";
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

// Pedidos activos asignados al repartidor
export const getAssignedPedidos = async (req, res) => {
  try {
    const [rows] = await db.query(
      `SELECT e.id_envio, e.estado, p.id_pedido, pa.descripcion AS paquete, d1.municipio AS origen, d2.municipio AS destino
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

// Historial de pedidos completados
export const getHistorialPedidos = async (req, res) => {
  try {
    const [rows] = await db.query(
      `SELECT e.id_envio, e.estado, p.id_pedido, pa.descripcion AS paquete, d1.municipio AS origen, d2.municipio AS destino, e.fecha_asignacion
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

// Última posición de un envío (para Mapbox)
export const getLastPosition = async (req, res) => {
  try {
    const { id_envio } = req.params;
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

// Detalle completo de un pedido específico
export const getPedidoDetalle = async (req, res) => {
  try {
    const { id_pedido } = req.params;

    const [rows] = await db.query(
      `SELECT 
         e.id_envio,
         e.estado,
         e.costo,
         e.fecha_asignacion,
         p.id_pedido,
         pa.descripcion AS paquete,
         pa.peso,
         pa.dimensiones,
         pa.fragil,
         d1.calle_principal AS origen_calle,
         d1.numero AS origen_numero,
         d1.calle_secundaria AS origen_secundaria,
         d1.zona AS origen_zona,
         d1.colonia_o_barrio AS origen_colonia,
         d1.municipio AS origen_municipio,
         d1.departamento AS origen_departamento,
         d1.codigo_postal AS origen_cp,
         d1.referencias AS origen_referencias,
         d2.calle_principal AS destino_calle,
         d2.numero AS destino_numero,
         d2.calle_secundaria AS destino_secundaria,
         d2.zona AS destino_zona,
         d2.colonia_o_barrio AS destino_colonia,
         d2.municipio AS destino_municipio,
         d2.departamento AS destino_departamento,
         d2.codigo_postal AS destino_cp,
         d2.referencias AS destino_referencias,
         p.nombre_destinatario,
         p.email_destinatario,
         p.telefono_destinatario
       FROM envio e
       JOIN pedido p ON e.id_pedido = p.id_pedido
       JOIN paquete pa ON p.id_paquete = pa.id_paquete
       JOIN direccion d1 ON p.id_direccion_origen = d1.id_direccion
       JOIN direccion d2 ON p.id_direccion_destino = d2.id_direccion
       WHERE p.id_pedido = ? AND e.id_repartidor = ?`,
      [id_pedido, req.user.id]
    );

    if (!rows.length)
      return res.status(404).json({ error: "Pedido no encontrado" });

    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// --- NUEVAS RUTAS PARA CAMBIAR ESTADO ---
export const marcarRecolectado = async (req, res) => {
  try {
    const { id_envio } = req.params;
    await db.query(
      "UPDATE envio SET estado = 'Recolectado' WHERE id_envio = ? AND id_repartidor = ?",
      [id_envio, req.user.id]
    );
    res.json({ msg: "Estado cambiado a Recolectado" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export const marcarEntregado = async (req, res) => {
  try {
    const { id_envio } = req.params;
    await db.query(
      "UPDATE envio SET estado = 'Entregado' WHERE id_envio = ? AND id_repartidor = ?",
      [id_envio, req.user.id]
    );
    res.json({ msg: "Estado cambiado a Entregado" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
