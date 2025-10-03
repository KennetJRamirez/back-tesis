import { transporter } from "../config/email.js";

export const normalizeString = (str) =>
  str
    ?.normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .trim()
    .toLowerCase();

export const enviarCorreo = async (email, nombre, subject, html) => {
  await transporter.sendMail({
    from: `"FastBox" <fastboxteam@gmail.com>`,
    to: email,
    subject,
    html,
  });
};
