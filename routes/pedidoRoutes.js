import { Router } from "express";
import { authMiddleware } from "../middlewares/authMiddleware.js";
import { createPedido } from "../controllers/pedidoController.js";

const router = Router();

router.post("/", authMiddleware, createPedido);

export default router;
