import express from "express";
import { authMiddleware } from "../middlewares/authMiddleware.js";
import { guestMiddleware } from "../middlewares/guestMiddleware.js";
import {
  getPedidoCliente,
  getLastPositionCliente,
  getLastPositionGuest
} from "../controllers/clienteController.js";

const router = express.Router();

// Ruta guest sin login normal
router.get("/guest/:token", guestMiddleware, getLastPositionGuest);


// Rutas protegidas por login normal
router.use(authMiddleware);

router.get("/pedido/:id_pedido", getPedidoCliente);
router.get("/tracking/:id_envio", getLastPositionCliente);


export default router;
