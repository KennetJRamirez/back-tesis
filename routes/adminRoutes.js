import { Router } from "express";
import { authMiddleware } from "../middlewares/authMiddleware.js";
import { authorizeRoles } from "../middlewares/roleMiddleware.js";
import {
  getAllUsers,
  getUserById,
  updateUser,
  changeUserRole,
  changeUserStatus,
  getPedidosPorEstado,
  getIngresosPorDia,
  getPedidosPorZona,
  getEntregasPorRepartidor
} from "../controllers/adminController.js";

const router = Router();

// Solo admin
router.use(authMiddleware, authorizeRoles(3));

// ---- Usuarios ----
router.get("/usuarios", getAllUsers);
router.get("/usuarios/:id", getUserById);
router.put("/usuarios/:id", updateUser);
router.put("/usuarios/:id/rol", changeUserRole);
router.put("/usuarios/:id/estado", changeUserStatus);

// ---- Reportes ----
router.get("/reportes/pedidos-estado", getPedidosPorEstado);
router.get("/reportes/ingresos-dia", getIngresosPorDia);
router.get("/reportes/pedidos-zona", getPedidosPorZona);
router.get("/reportes/entregas-repartidor", getEntregasPorRepartidor);

export default router;
