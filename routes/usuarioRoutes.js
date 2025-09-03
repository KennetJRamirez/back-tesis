import { Router } from "express";
import { authMiddleware } from "../middlewares/authMiddleware.js";
import {
	getProfile,
	updateProfile,
	changePassword,
} from "../controllers/usuarioController.js";

const router = Router();

// Rutas protegidas
router.get("/me", authMiddleware, getProfile);
router.put("/me", authMiddleware, updateProfile);
router.put("/me/password", authMiddleware, changePassword);

export default router;
