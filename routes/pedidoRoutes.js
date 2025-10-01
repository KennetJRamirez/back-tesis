import { Router } from "express";
import { authMiddleware } from "../middlewares/authMiddleware.js";
import { createPedido,getMisPedidos,calcularCostoPedido  } from "../controllers/pedidoController.js";

const router = Router();

router.post("/", authMiddleware, createPedido);
router.post("/calcular", authMiddleware, calcularCostoPedido);
router.get("/mios", authMiddleware, getMisPedidos);

export default router;
