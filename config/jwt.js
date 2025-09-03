import jwt from "jsonwebtoken";

const SECRET = "supersecretoxd";

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

export const verifyToken = (token) => {
	return jwt.verify(token, SECRET);
};
