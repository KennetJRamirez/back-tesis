import jwt from "jsonwebtoken";
import dotenv from "dotenv";

dotenv.config();

const SECRET = process.env.JWT_SECRET;

// Token normal (usuario logueado)
export const generateToken = (usuario) => {
  return jwt.sign(
    {
      id: usuario.id_usuario,
      rol: usuario.id_rol,
    },
    SECRET,
    { expiresIn: "1h" }
  );
};

// Token invitado (solo seguimiento de envío)
export const generateGuestToken = (id_envio) => {
  return jwt.sign(
    {
      guest: true,
      id_envio,
    },
    SECRET,
    { expiresIn: "30h" }
  );
};

// Verificar cualquier token
export const verifyToken = (token) => {
  return jwt.verify(token, SECRET);
};
