import { body, param, validationResult } from "express-validator";

const handleErrors = (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty())
    return res.status(400).json({ errors: errors.array() });
  next();
};

// Obtener usuario por ID
export const validateGetUserById = [
  param("id").isInt({ min: 1 }).withMessage("ID inválido"),
  handleErrors,
];

// Actualizar usuario (nombre, tel, email)
export const validateUpdateUser = [
  param("id").isInt({ min: 1 }).withMessage("ID inválido"),
  body("nombre").notEmpty().withMessage("El nombre es obligatorio"),
  body("telefono")
    .optional()
    .isMobilePhone("any")
    .withMessage("Teléfono inválido"),
  body("email").isEmail().withMessage("Email inválido"),
  handleErrors,
];

// Cambiar rol de usuario
export const validateChangeUserRole = [
  param("id").isInt({ min: 1 }).withMessage("ID inválido"),
  body("id_rol").isInt({ min: 1 }).withMessage("Rol inválido"),
  handleErrors,
];

// Cambiar estado activo/inactivo
export const validateChangeUserStatus = [
  param("id").isInt({ min: 1 }).withMessage("ID inválido"),
  body("activo").isBoolean().withMessage("El estado debe ser true/false"),
  handleErrors,
];

// RepartidorID
export const validateRepartidorId = [
  param("id").isInt({ min: 1 }).withMessage("ID de repartidor inválido"),
  handleErrors,
];

// RepartidorZona
export const validateZonaBody = [
  body("municipio").notEmpty().withMessage("Municipio obligatorio"),
  body("zona").isInt({ min: 1 }).withMessage("Zona inválida"),
  handleErrors,
];
