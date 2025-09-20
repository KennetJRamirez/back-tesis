import express from "express";
import { authMiddleware } from "../middlewares/authMiddleware.js";
import {
  getPedidoCliente,
  getLastPositionCliente,
} from "../controllers/clienteController.js";

const router = express.Router();

// Middleware para todas las rutas de cliente
router.use(authMiddleware);

// PEDIDOS DEL CLIENTE
router.get("/pedido/:id_pedido", getPedidoCliente);
router.get("/tracking/:id_envio", getLastPositionCliente);

export default router;
