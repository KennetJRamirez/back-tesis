// tarifas.js (corregido, data-driven)
export const tarifas = [
  // 1) CAES municipales (Q40) — aplica al municipio completo
  {
    nombre: "CAES municipios (Q40)",
    municipios: ["San José Pinula", "Fraijanes"],
    precio: 40.0,
  },

  // 2) CAES Mixco zonas (Q40) — zonas específicas dentro de Mixco
  {
    nombre: "CAES Mixco zonas (Q40)",
    municipios: ["Mixco"],
    zonas: [9, 11],
    precio: 40.0,
  },

  // 3) CAES Villa Nueva zonas (Q40) — zonas específicas dentro de Villa Nueva
  {
    nombre: "CAES Villa Nueva zonas (Q40)",
    municipios: ["Villa Nueva"],
    zonas: [3, 10],
    precio: 40.0,
  },

  // 4) Zonas globales 17-19 -> Q35 (aplica independientemente del municipio)
  {
    nombre: "Zonas 17-19 (Q35) - global",
    zonas: [17, 18, 19],
    precio: 35.0,
  },

  // 5) Zonas Mixco y alrededores (Q35) — municipio-level (salvo overrides arriba)
  {
    nombre: "Zonas Mixco y alrededores (Q35)",
    municipios: ["Mixco", "San Miguel Petapa", "Villa Nueva"],
    zonas: [1, 2, 3,4, 5, 6, 7,9, 8, 10], // 3 y 10 de Villa Nueva siguen siendo override Q40 arriba
    precio: 35.0,
  },

  // 6) Zonas de la ciudad (Guatemala) 1-16 -> Q25
  {
    nombre: "Zonas de la Ciudad (1–16) (Q25)",
    municipios: ["Guatemala"],
    zonas: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16],
    precio: 25.0,
  },
];

// helper: normaliza strings (quita acentos, trim, toLowerCase)
function normalize(str) {
  return String(str || "")
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .trim()
    .toLowerCase();
}

/**
 * calcularTarifa({ zona, municipio })
 * - Busca en 'tarifas' en orden; primera regla que "coincida" devuelve precio.
 * - Reglas con 'municipios' requieren que municipio coincida.
 * - Reglas con 'zonas' requieren que la zona coincida.
 * - Si una regla tiene ambos, ambos deben coincidir.
 */
export function calcularTarifa({ zona, municipio }) {
  const z = Number(zona);
  const mun = normalize(municipio);
  const hasZone = Number.isFinite(z) && !Number.isNaN(z);

  for (const t of tarifas) {
    let ok = true;

    // si la tarifa tiene municipios, chequear municipio
    if (t.municipios) {
      const munList = t.municipios.map(m => normalize(m));
      if (!mun || !munList.includes(mun)) ok = false;
    }

    // si la tarifa tiene zonas, chequear zona
    if (t.zonas) {
      if (!hasZone || !t.zonas.includes(z)) ok = false;
    }

    if (ok) return t.precio;
  }

  // si no queda nada, devuelve null para que el caller maneje el caso
  return null;
}
