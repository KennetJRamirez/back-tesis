import nodemailer from "nodemailer";

export const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "fastboxteam@gmail.com", 
    pass: "npwv apbr eqmv kpvl", 
  },
});
