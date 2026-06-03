"use client";

import { useState } from "react";

export function AddFestivalForm() {
  const [status, setStatus] = useState<string | null>(null);

  async function onSubmit(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setStatus("Guardando...");
    const form = event.currentTarget;
    const payload = Object.fromEntries(new FormData(form).entries());
    const response = await fetch("/api/festivals", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(payload)
    });
    const result = await response.json();
    if (!response.ok) {
      setStatus(result.error || "No se pudo guardar");
      return;
    }
    setStatus("Festival guardado. Recarga la página para verlo en el listado.");
    form.reset();
  }

  return (
    <form className="card grid" onSubmit={onSubmit}>
      <div>
        <p className="eyebrow">Nuevo festival</p>
        <h2>Añadir oportunidad manual</h2>
        <p className="muted">Útil para meter rápido un festival detectado por Instagram, prensa o contacto directo.</p>
      </div>
      <div className="form-grid">
        <input className="input" name="name" placeholder="Nombre del festival" required />
        <input className="input" name="city" placeholder="Localidad" />
        <input className="input" name="province" placeholder="Provincia" />
        <input className="input" name="region" placeholder="Comunidad autónoma" />
        <input className="input" name="start_date" type="date" />
        <input className="input" name="end_date" type="date" />
        <input className="input" name="instagram_url" placeholder="Instagram oficial" />
        <input className="input" name="official_website" placeholder="Web oficial" />
        <input className="input" name="expected_attendance" type="number" placeholder="Asistencia estimada" />
        <select className="select" name="sales_stage" defaultValue="Detectado">
          <option>Detectado</option>
          <option>Fechas anunciadas</option>
          <option>Cartel parcial</option>
          <option>Venta activa</option>
          <option>Tramo 1</option>
          <option>Tramo 2</option>
          <option>Últimos abonos</option>
          <option>Sold out</option>
          <option>Post-evento</option>
        </select>
      </div>
      <div className="actions">
        <button className="btn primary" type="submit">Guardar festival</button>
        {status ? <span className="muted">{status}</span> : null}
      </div>
    </form>
  );
}
