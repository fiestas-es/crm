"use client";

import { useState } from "react";

export function RunRadarButton() {
  const [loading, setLoading] = useState(false);
  const [result, setResult] = useState<any>(null);
  const [error, setError] = useState<string | null>(null);

  async function run() {
    setLoading(true);
    setError(null);
    setResult(null);

    try {
      const response = await fetch("/api/radar/run", { method: "POST" });
      const data = await response.json();
      if (!response.ok) throw new Error(data.error || "No se pudo ejecutar el radar");
      setResult(data.result || data);
    } catch (err: any) {
      setError(err.message || "Error desconocido");
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="radar-runner-v7">
      <button className="btn primary" onClick={run} disabled={loading}>
        {loading ? "Ejecutando radar..." : "Ejecutar radar ahora"}
      </button>
      {error ? <p className="error">{error}</p> : null}
      {result ? (
        <div className="success radar-result-v7">
          <strong>Radar completado</strong>
          <pre>{JSON.stringify(result, null, 2)}</pre>
        </div>
      ) : null}
    </div>
  );
}
