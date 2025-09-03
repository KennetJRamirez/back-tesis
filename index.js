import express from "express";
import authRoutes from "./routes/authRoutes.js";
import usuarioRoutes from "./routes/usuarioRoutes.js";
import adminRoutes from "./routes/adminRoutes.js";
import pedidoRoutes from "./routes/pedidoRoutes.js";

const app = express();
app.use(express.json());

app.use("/auth", authRoutes);
app.use("/usuario", usuarioRoutes);
app.use("/admin", adminRoutes);
app.use("/pedido", pedidoRoutes);

app.listen(3000, () =>
	console.log("Servidor corriendo en http://localhost:3000")
);
