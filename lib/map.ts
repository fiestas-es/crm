import type { FestivalOverview } from "./types";

type Coord = { lat: number; lon: number };

const cityFallbacks: Record<string, Coord> = {
  madrid: { lat: 40.4168, lon: -3.7038 },
  barcelona: { lat: 41.3874, lon: 2.1686 },
  bilbao: { lat: 43.263, lon: -2.935 },
  burriana: { lat: 39.889, lon: -0.085 },
  castellon: { lat: 39.986, lon: -0.051 },
  castelló: { lat: 39.986, lon: -0.051 },
  villarrobledo: { lat: 39.267, lon: -2.607 },
  fraga: { lat: 41.522, lon: 0.348 },
  benicassim: { lat: 40.056, lon: 0.065 },
  benicàssim: { lat: 40.056, lon: 0.065 },
  benidorm: { lat: 38.541, lon: -0.123 },
  viveiro: { lat: 43.663, lon: -7.594 },
  sevilla: { lat: 37.389, lon: -5.984 },
  málaga: { lat: 36.721, lon: -4.421 },
  malaga: { lat: 36.721, lon: -4.421 },
  valencia: { lat: 39.4699, lon: -0.3763 },
  zaragoza: { lat: 41.6488, lon: -0.8891 },
  gijón: { lat: 43.532, lon: -5.661 },
  gijon: { lat: 43.532, lon: -5.661 },
  oviedo: { lat: 43.361, lon: -5.849 },
  granada: { lat: 37.177, lon: -3.598 },
  murcia: { lat: 37.984, lon: -1.129 },
  pamplona: { lat: 42.812, lon: -1.645 },
  santander: { lat: 43.462, lon: -3.81 },
  "a coruña": { lat: 43.362, lon: -8.411 },
  "la coruña": { lat: 43.362, lon: -8.411 },
  santiago: { lat: 42.878, lon: -8.544 },
  vigo: { lat: 42.24, lon: -8.72 },
  logroño: { lat: 42.462, lon: -2.445 },
  calvià: { lat: 39.565, lon: 2.506 },
  calvia: { lat: 39.565, lon: 2.506 },
  ibiza: { lat: 38.906, lon: 1.42 },
  "santa cruz de tenerife": { lat: 28.463, lon: -16.251 },
  tenerife: { lat: 28.463, lon: -16.251 },
  "las palmas": { lat: 28.124, lon: -15.43 }
};

function normalize(value?: string | null) {
  return (value || "")
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .trim();
}

export function resolveFestivalCoordinates(festival: FestivalOverview): Coord | null {
  if (typeof festival.latitude === "number" && typeof festival.longitude === "number") {
    return { lat: festival.latitude, lon: festival.longitude };
  }

  const city = normalize(festival.city);
  const province = normalize(festival.province);
  const region = normalize(festival.region);

  return cityFallbacks[city] || cityFallbacks[province] || cityFallbacks[region] || null;
}

export function projectSpainPoint(coord: Coord) {
  const { lat, lon } = coord;

  // Canarias como inset inferior izquierdo.
  if (lon < -12 && lat < 31) {
    const x = 8 + ((lon + 18.4) / 4.6) * 23;
    const y = 80 + ((29.6 - lat) / 2.6) * 13;
    return { x: clamp(x, 5, 34), y: clamp(y, 78, 96), zone: "canarias" as const };
  }

  // Baleares como inset derecho.
  if (lon > 1 && lat < 40.5) {
    const x = 78 + ((lon - 1.0) / 3.5) * 17;
    const y = 39 + ((40.4 - lat) / 2.1) * 15;
    return { x: clamp(x, 76, 97), y: clamp(y, 36, 59), zone: "baleares" as const };
  }

  // Península + Ceuta/Melilla.
  const lonMin = -9.6;
  const lonMax = 3.4;
  const latMin = 35.7;
  const latMax = 43.9;
  const x = 14 + ((lon - lonMin) / (lonMax - lonMin)) * 65;
  const y = 10 + ((latMax - lat) / (latMax - latMin)) * 70;
  return { x: clamp(x, 7, 86), y: clamp(y, 6, 82), zone: "peninsula" as const };
}

function clamp(value: number, min: number, max: number) {
  return Math.max(min, Math.min(max, value));
}

export function scoreColor(score: number) {
  if (score >= 80) return "hot";
  if (score >= 65) return "warm";
  if (score >= 45) return "cool";
  return "cold";
}
