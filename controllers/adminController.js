import { db } from "../config/db.js";

export const getAllUsers = async (req, res) => {
  try {
    const [rows] = await db.query(
      "SELECT id_usuario, nombre, telefono, email, id_rol, activo FROM usuario"
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export const getUserById = async (req, res) => {
  try {
    const { id } = req.params;
    const [rows] = await db.query(
      "SELECT id_usuario, nombre, telefono, email, id_rol, activo FROM usuario WHERE id_usuario = ?",
      [id]
    );
    if (rows.length === 0)
      return res.status(404).json({ error: "Usuario no encontrado" });
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export const updateUser = async (req, res) => {
  try {
    const { id } = req.params;
    const { nombre, telefono, email } = req.body;

    await db.query(
      "UPDATE usuario SET nombre = ?, telefono = ?, email = ? WHERE id_usuario = ?",
      [nombre, telefono, email, id]
    );
    res.json({ msg: "Usuario actualizado" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export const changeUserRole = async (req, res) => {
  try {
    const { id } = req.params;
    const { id_rol } = req.body;

    await db.query("UPDATE usuario SET id_rol = ? WHERE id_usuario = ?", [
      id_rol,
      id,
    ]);
    res.json({ msg: "Rol actualizado" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export const changeUserStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { activo } = req.body; 

    await db.query("UPDATE usuario SET activo = ? WHERE id_usuario = ?", [
      activo,
      id,
    ]);
    res.json({ msg: "Estado de usuario actualizado" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Reporteria
// Pedidos por estado
export const getPedidosPorEstado = async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT estado, COUNT(*) AS total 
      FROM envio 
      GROUP BY estado
    `);
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: "Error al obtener pedidos por estado" });
  }
};

// Ingresos por día
export const getIngresosPorDia = async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT DATE(fecha_asignacion) AS fecha, SUM(costo) AS ingresos
      FROM envio
      GROUP BY DATE(fecha_asignacion)
      ORDER BY fecha DESC
    `);
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: "Error al obtener ingresos" });
  }
};

// Pedidos por zona
export const getPedidosPorZona = async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT municipio, zona, COUNT(*) AS total
      FROM pedido p
      JOIN direccion d ON p.id_direccion_destino = d.id_direccion
      GROUP BY municipio, zona
      ORDER BY total DESC
    `);
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: "Error al obtener pedidos por zona" });
  }
};

// Repartidores con más entregas
export const getEntregasPorRepartidor = async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT u.nombre AS repartidor, COUNT(e.id_envio) AS entregados
      FROM envio e
      JOIN usuario u ON e.id_repartidor = u.id_usuario
      WHERE e.estado = 'Entregado'
      GROUP BY u.id_usuario
    `);
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: "Error al obtener entregas por repartidor" });
  }
};
