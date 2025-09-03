import { verifyToken } from "../config/jwt.js";

export const authMiddleware = (req, res, next) => {
	const token = req.headers["authorization"]?.split(" ")[1];
	if (!token) return res.status(401).json({ error: "Token requerido" });

	try {
		const decoded = verifyToken(token);
		req.user = decoded;
		next();
	} catch (err) {
		return res.status(403).json({ error: "Token inválido" });
	}
};
