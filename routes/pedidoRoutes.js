import { Router } from "express";
import { authMiddleware } from "../middlewares/authMiddleware.js";
import {
  createPedido,
  getMisPedidos,
  calcularCostoPedido,
} from "../controllers/pedidoController.js";
import { validarPedido } from "../middlewares/pedidoValidator.js";

const router = Router();

// Crear pedido, primero por authMiddleware y luego por validarPedido
router.post("/", authMiddleware, validarPedido, createPedido);

// Calcular costo
router.post("/calcular", authMiddleware, calcularCostoPedido);

// Obtener pedidos del usuario
router.get("/mios", authMiddleware, getMisPedidos);

export default router;
