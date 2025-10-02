import { body, validationResult } from "express-validator";

// ---------------- REGISTER ----------------
export const validateRegister = [
  body("nombre").notEmpty().withMessage("El nombre es obligatorio"),
  body("telefono")
    .optional()
    .isMobilePhone("es-GT")
    .withMessage("Teléfono inválido (Guatemala)"),
  body("email").isEmail().withMessage("Email inválido"),
  body("password")
    .isLength({ min: 8 })
    .withMessage("Password mínimo de 8 caracteres"),
  (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty())
      return res.status(400).json({ errors: errors.array() });
    next();
  },
];

// ---------------- LOGIN ----------------
export const validateLogin = [
  body("email").isEmail().withMessage("Email inválido"),
  body("password").notEmpty().withMessage("Password obligatorio"),
  (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty())
      return res.status(400).json({ errors: errors.array() });
    next();
  },
];
