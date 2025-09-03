export const tarifas = [
  {
    nombre: "Zonas de la Ciudad (1-16)",
    zonas: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16],
    precio: 25.0,
  },
  {
    nombre: "CAES desde km 1-8",
    km: { inicio: 1, fin: 8 },
    precio: 30.0,
  },
  {
    nombre: "Mixco y alrededores",
    zonas: [1, 2, 3, 4, 5, 6, 7, 8, 10, 17, 18, 19],
    municipios: ["San Miguel Petapa", "Villa Nueva"],
    km: { inicio: 9, fin: 19 },
    precio: 35.0,
  },
  {
    nombre: "CAES 20-25 + municipios extra",
    municipios: ["San Jose Pinula", "Fraijanes"],
    zonas: [3, 10],
    zonasMixco: [9, 11],
    km: { inicio: 20, fin: 25 },
    precio: 40.0,
  },
];

// función corregida: zona > municipio+km > km
export function calcularTarifa({ zona, municipio, km }) {
  for (const t of tarifas) {
    // 1️⃣ Si la tarifa tiene zonas y coincide
    if (t.zonas && t.zonas.includes(Number(zona))) return t.precio;

    // 2️⃣ Si la tarifa tiene municipios
    if (t.municipios && t.municipios.includes(municipio)) {
      // Si también tiene km, combinar
      if (t.km) {
        if (km >= t.km.inicio && km <= t.km.fin) return t.precio;
      } else {
        return t.precio;
      }
    }

    // 3️⃣ Si solo tiene km
    if (t.km && km >= t.km.inicio && km <= t.km.fin) {
      if (t.municipios && !t.municipios.includes(municipio)) continue;
      return t.precio;
    }
  }

  return null;
}
