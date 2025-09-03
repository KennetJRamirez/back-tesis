import { Router } from "express";
import { authMiddleware } from "../middlewares/authMiddleware.js";
import { authorizeRoles } from "../middlewares/roleMiddleware.js";
import {
  getAllUsers,
  getUserById,
  updateUser,
  changeUserRole,
  changeUserStatus,
} from "../controllers/adminController.js";

const router = Router();

// Solo admin
router.use(authMiddleware, authorizeRoles(3));

router.get("/usuarios", getAllUsers);
router.get("/usuarios/:id", getUserById);
router.put("/usuarios/:id", updateUser);
router.put("/usuarios/:id/rol", changeUserRole);
router.put("/usuarios/:id/estado", changeUserStatus);

export default router;
