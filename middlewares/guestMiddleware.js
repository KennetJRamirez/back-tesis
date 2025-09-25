import { verifyToken } from "../config/jwt.js";

export const guestMiddleware = (req, res, next) => {
  const { token } = req.params;
  if (!token) return res.status(401).json({ error: "Token requerido" });

  try {
    const decoded = verifyToken(token);

    if (!decoded.guest || !decoded.id_envio) {
      return res.status(403).json({ error: "Token inválido o expirado" });
    }

    req.guest = { id_envio: decoded.id_envio };
    next();
  } catch (err) {
    return res.status(403).json({ error: "Token inválido o expirado" });
  }
};
