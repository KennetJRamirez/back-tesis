import express from "express";
import { authMiddleware } from "../middlewares/authMiddleware.js";
import {
  getProfile,
  updateProfile,
  changePassword,
  getAssignedPedidos,
  getHistorialPedidos,
  savePosition,
  getLastPosition,
  marcarRecolectado,
  marcarEntregado,
} from "../controllers/repartidorController.js";

const router = express.Router();

// Middleware para todas las rutas de repartidor
router.use(authMiddleware);

// PERFIL
router.get("/perfil", getProfile);
router.put("/perfil", updateProfile);
router.put("/perfil/password", changePassword);

// PEDIDOS
router.get("/pedidos/activos", getAssignedPedidos);
router.get("/pedidos/historial", getHistorialPedidos);

// TRACKING
router.post("/tracking/:id_envio", savePosition);
router.get("/tracking/:id_envio", getLastPosition);

// ESTADO PEDIDOS
router.put("/pedidos/:id_envio/recolectado", marcarRecolectado);
router.put("/pedidos/:id_envio/entregado", marcarEntregado);

router.get('/tracking/:id_envio/last', authMiddleware, getLastPosition);

export default router;
