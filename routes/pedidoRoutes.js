import { Router } from "express";
import { authMiddleware } from "../middlewares/authMiddleware.js";
import { createPedido,getMisPedidos  } from "../controllers/pedidoController.js";

const router = Router();

router.post("/", authMiddleware, createPedido);
router.get("/mios", authMiddleware, getMisPedidos);

export default router;
