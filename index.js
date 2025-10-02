import express from "express";
import cors from "cors";
import authRoutes from "./routes/authRoutes.js";
import usuarioRoutes from "./routes/usuarioRoutes.js";
import adminRoutes from "./routes/adminRoutes.js";
import pedidoRoutes from "./routes/pedidoRoutes.js";
import repartidorRoutes from "./routes/repartidorRoutes.js";
import clienteRoutes from "./routes/clienteRoutes.js";

const app = express();

app.disable("x-powered-by");

const allowedOrigins = [
  "http://localhost:4200",
  "http://127.0.0.1:4200",
  "https://localhost:4200",
  "https://127.0.0.1:4200",
];

app.use(
  cors({
    origin: function (origin, callback) {
      console.log("CORS origin recibido:", origin);
      if (!origin) return callback(null, true);
      if (allowedOrigins.includes(origin)) return callback(null, true);
      return callback(new Error("No permitido por CORS"));
    },
    credentials: true,
  })
);

app.use(express.json());

// Rutas
app.use("/auth", authRoutes);
app.use("/usuario", usuarioRoutes);
app.use("/admin", adminRoutes);
app.use("/pedido", pedidoRoutes);
app.use("/repartidor", repartidorRoutes);
app.use("/cliente", clienteRoutes);

// Catch-all global para 404 (después de todas las rutas)
app.use((req, res) => {
  res.status(404).json({ error: "Not Found" });
});

app.listen(3000, () => {
  console.log("Servidor corriendo en http://localhost:3000");
});
