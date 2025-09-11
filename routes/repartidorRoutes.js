import { Router } from "express";
import { authMiddleware } from "../middlewares/authMiddleware.js";
import { authorizeRoles } from "../middlewares/roleMiddleware.js";
import {
  getProfile,
  updateProfile,
  changePassword,
  getAssignedPedidos,
  getHistorialPedidos,
  getLastPosition,
  getPedidoDetalle,
  marcarRecolectado,
  marcarEntregado,
} from "../controllers/repartidorController.js";

const router = Router();

router.use(authMiddleware, authorizeRoles(2));

router.get("/me", getProfile);
router.put("/me", updateProfile);
router.put("/me/password", changePassword);

// Pedidos
router.get("/pedidos/activos", getAssignedPedidos);
router.get("/pedidos/historial", getHistorialPedidos);

// Tracking
router.get("/tracking/:id_envio", getLastPosition);

router.get("/pedidos/:id_pedido", getPedidoDetalle);

router.put("/pedidos/:id_envio/recolectado", marcarRecolectado);
router.put("/pedidos/:id_envio/entregado", marcarEntregado);
export default router;
