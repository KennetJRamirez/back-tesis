export const validarPedido = (req, res, next) => {
  const { paquete, direccion_origen, direccion_destino, destinatario } =
    req.body;

  // Validar paquete
  if (!paquete) {
    return res.status(400).json({ error: "Falta el objeto 'paquete'" });
  }
  const { descripcion, peso, dimensiones, fragil } = paquete;
  if (!descripcion || !peso || !dimensiones) {
    return res.status(400).json({
      error:
        "Todos los campos del paquete son obligatorios: descripcion, peso, dimensiones",
    });
  }
  if (typeof fragil !== "boolean") {
    return res
      .status(400)
      .json({ error: "El campo 'fragil' debe ser booleano" });
  }

  // Validar direcciones
  const validarDireccion = (direccion, nombre) => {
    const requiredFields = [
      "calle_principal",
      "numero",
      "calle_secundaria",
      "zona",
      "colonia_o_barrio",
      "municipio",
      "departamento",
      "codigo_postal",
      "referencias",
    ];
    for (const field of requiredFields) {
      if (!direccion?.[field]) {
        return `Falta '${field}' en la ${nombre}`;
      }
    }
    return null;
  };

  let error = validarDireccion(direccion_origen, "direccion_origen");
  if (error) return res.status(400).json({ error });

  error = validarDireccion(direccion_destino, "direccion_destino");
  if (error) return res.status(400).json({ error });

  // Validar destinatario
  if (!destinatario) {
    return res.status(400).json({ error: "Falta el objeto 'destinatario'" });
  }
  const { nombre, email, telefono } = destinatario;
  if (!nombre || !email || !telefono) {
    return res.status(400).json({
      error:
        "Todos los campos del destinatario son obligatorios: nombre, email, telefono",
    });
  }

  // Si todo ok
  next();
};
