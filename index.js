import express from "express";
import cors from "cors"; // <- importar cors
import authRoutes from "./routes/authRoutes.js";
import usuarioRoutes from "./routes/usuarioRoutes.js";
import adminRoutes from "./routes/adminRoutes.js";
import pedidoRoutes from "./routes/pedidoRoutes.js";
import repartidorRoutes from "./routes/repartidorRoutes.js";
import clienteRoutes from "./routes/clienteRoutes.js"; // 👈 nuevo

const app = express();

app.use(
  cors({
    origin: "http://localhost:4200", // <- tu frontend Angular
    credentials: true, // <- permite cookies
  })
);

app.use(express.json());

// Rutas
app.use("/auth", authRoutes);
app.use("/usuario", usuarioRoutes);
app.use("/admin", adminRoutes);
app.use("/pedido", pedidoRoutes);
app.use("/repartidor", repartidorRoutes);
app.use("/cliente", clienteRoutes); // 👈 nuevo

// Arrancar servidor
app.listen(3000, () =>
  console.log("Servidor corriendo en http://localhost:3000")
);
