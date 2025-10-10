import express from "express";
import cors from "cors";
import authRoutes from "./routes/authRoutes.js";
import usuarioRoutes from "./routes/usuarioRoutes.js";
import adminRoutes from "./routes/adminRoutes.js";
import pedidoRoutes from "./routes/pedidoRoutes.js";
import repartidorRoutes from "./routes/repartidorRoutes.js";
import clienteRoutes from "./routes/clienteRoutes.js";
import "./jobs/cleanTracking.js";

const app = express();

app.disable("x-powered-by");

app.use(
  cors({
    origin: true,      
    credentials: true,   
  })
);

app.use(express.json());

// Rutas
app.use("/api/auth", authRoutes);
app.use("/api/usuario", usuarioRoutes);
app.use("/api/admin", adminRoutes);
app.use("/api/pedido", pedidoRoutes);
app.use("/api/repartidor", repartidorRoutes);
app.use("/api/cliente", clienteRoutes);

// Catch-all global para 404
app.use((req, res) => {
  res.status(404).json({ error: "Not Found" });
});

app.listen(3000, () => {
  console.log("Servidor corriendo en http://localhost:3000");
});
