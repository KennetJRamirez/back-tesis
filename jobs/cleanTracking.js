import cron from "node-cron";
import { db } from "../config/db.js";

cron.schedule("*/1 * * * *", async () => {
  try {
    await db.query(`
      DELETE te FROM tracking_envio te
      INNER JOIN (
          SELECT id_tracking FROM (
              SELECT id_tracking,
                     ROW_NUMBER() OVER (PARTITION BY id_envio ORDER BY fecha_hora DESC) AS rn
              FROM tracking_envio
          ) t
          WHERE t.rn > 15
      ) old_positions
      ON te.id_tracking = old_positions.id_tracking
    `);
    console.log("Job: posiciones antiguas eliminadas");
  } catch (err) {
    console.error("Error en job de limpieza de tracking:", err.message);
  }
});
