import mysql from "mysql2/promise";

export const db = mysql.createPool({
	host: "127.0.0.1",
	user: "root",
	password: "root",
	database: "db_fastbox",
	port: 3306,
});
