import { db } from "../config/db.js";
import { hashPassword, comparePassword } from "../utils/hash.js";
import { generateToken } from "../config/jwt.js";

export const register = async (req, res) => {
	try {
		const { nombre, telefono, email, password, id_rol } = req.body;
		const rolAsignado = id_rol || 1;
		const hashed = await hashPassword(password);

		const [result] = await db.query(
			"INSERT INTO usuario (nombre,telefono, email, password, id_rol) VALUES (?, ?, ?, ?, ?)",
			[nombre, telefono, email, hashed, rolAsignado]
		);

		res.json({ id: result.insertId, nombre, telefono, email, id_rol });
	} catch (err) {
		if (err.code === 'ER_DUP_ENTRY') {
			return res.status(409).json({ error: "Usuario ya existe" });
		}
		res.status(500).json({ error: err.message });
	}
};

export const login = async (req, res) => {
	try {
		const { email, password } = req.body;
		const [rows] = await db.query("SELECT * FROM usuario WHERE email = ?", [
			email,
		]);

		if (rows.length === 0)
			return res.status(400).json({ error: "No existe usuario" });

		const usuario = rows[0];
		const valid = await comparePassword(password, usuario.password);
		if (!valid)
			return res.status(400).json({ error: "Password incorrecto" });

		const token = generateToken(usuario);
		res.json({ token, rol: usuario.id_rol });
	} catch (err) {
		res.status(500).json({ error: err.message });
	}
};

export const logout = (req, res) => {
    try {
        // Limpiar cookies en el navegador
        res.clearCookie("token", { path: "/", sameSite: "None", secure: true });
        res.clearCookie("rol", { path: "/", sameSite: "None", secure: true });

        res.status(200).json({ message: "Logout exitoso" });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};
