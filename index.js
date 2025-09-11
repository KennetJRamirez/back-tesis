import express from "express";
import cors from "cors"; // <- importar cors
import authRoutes from "./routes/authRoutes.js";
import usuarioRoutes from "./routes/usuarioRoutes.js";
import adminRoutes from "./routes/adminRoutes.js";
import pedidoRoutes from "./routes/pedidoRoutes.js";
import repartidorRoutes from "./routes/repartidorRoutes.js";
const app = express();

app.use(
  cors({
    origin: "http://localhost:4200", // <- tu frontend
    credentials: true, // <- permite cookies
  })
);

app.use(express.json());

app.use("/auth", authRoutes);
app.use("/usuario", usuarioRoutes);
app.use("/admin", adminRoutes);
app.use("/pedido", pedidoRoutes);
app.use("/repartidor", repartidorRoutes);

app.listen(3000, () =>
  console.log("Servidor corriendo en http://localhost:3000")
);
