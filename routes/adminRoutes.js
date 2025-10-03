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
  getEntregasPorRepartidor,
} from "../controllers/adminController.js";

import {
  validateGetUserById,
  validateUpdateUser,
  validateChangeUserRole,
  validateChangeUserStatus,
} from "../middlewares/adminValidator.js";

import { getRepartidorZonas, assignZona, removeZona } from "../controllers/adminController.js";
import { validateRepartidorId, validateZonaBody } from "../middlewares/adminValidator.js";


const router = Router();

// Solo admin
router.use(authMiddleware, authorizeRoles(3));

// ---- Usuarios ----
router.get("/usuarios", getAllUsers);
router.get("/usuarios/:id", validateGetUserById, getUserById);
router.put("/usuarios/:id", validateUpdateUser, updateUser);
router.put("/usuarios/:id/rol", validateChangeUserRole, changeUserRole);
router.put("/usuarios/:id/estado", validateChangeUserStatus, changeUserStatus);

// ---- Reportes ----
router.get("/reportes/pedidos-estado", getPedidosPorEstado);
router.get("/reportes/ingresos-dia", getIngresosPorDia);
router.get("/reportes/pedidos-zona", getPedidosPorZona);
router.get("/reportes/entregas-repartidor", getEntregasPorRepartidor);


// Repartidor
// Zonas de repartidor
router.get("/usuarios/:id/zonas", validateRepartidorId, getRepartidorZonas);
router.post("/usuarios/:id/zonas", validateRepartidorId, validateZonaBody, assignZona);
router.delete("/usuarios/:id/zonas", validateRepartidorId, validateZonaBody, removeZona);
export default router;
