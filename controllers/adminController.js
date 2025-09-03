import { db } from "../config/db.js";

// Ver todos los usuarios
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

// Ver un usuario por ID
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

// Editar información de un usuario
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

// Cambiar rol
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

// Cambiar estado activo/inactivo
export const changeUserStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { activo } = req.body; // true / false

    await db.query("UPDATE usuario SET activo = ? WHERE id_usuario = ?", [
      activo,
      id,
    ]);
    res.json({ msg: "Estado de usuario actualizado" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
