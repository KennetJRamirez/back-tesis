import { db } from "../config/db.js";

export const checkEnvioOwnership = async (req, res, next) => {
  const { id_envio } = req.params;
  try {
    const [check] = await db.query(
      "SELECT id_envio FROM envio WHERE id_envio = ? AND id_repartidor = ?",
      [id_envio, req.user.id]
    );
    if (check.length === 0)
      return res
        .status(403)
        .json({ error: `No autorizado para el envío ${id_envio}` });
    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export const validarUpdateProfile = (req, res, next) => {
  const { nombre, telefono, email } = req.body;
  if (!nombre || !telefono || !email)
    return res
      .status(400)
      .json({ error: "Nombre, teléfono y email son obligatorios" });
  next();
};

export const validarChangePassword = (req, res, next) => {
  const { currentPassword, newPassword } = req.body;
  if (!currentPassword || !newPassword)
    return res
      .status(400)
      .json({ error: "Contraseña actual y nueva son obligatorias" });
  if (newPassword.length < 8)
    return res
      .status(400)
      .json({ error: "La nueva contraseña debe tener al menos 8 caracteres" });
  next();
};

export const validarPosition = (req, res, next) => {
  const { latitud, longitud } = req.body;
  if (latitud === undefined || longitud === undefined)
    return res
      .status(400)
      .json({ error: "Latitud y longitud son obligatorias" });
  if (isNaN(latitud) || isNaN(longitud))
    return res
      .status(400)
      .json({ error: "Latitud y longitud deben ser números válidos" });
  next();
};
