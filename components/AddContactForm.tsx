"use client";

import { useState } from "react";

export function AddContactForm({ festivalId }: { festivalId: string }) {
  const [status, setStatus] = useState<string | null>(null);

  async function onSubmit(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setStatus("Guardando contacto...");
    const form = event.currentTarget;
    const payload = Object.fromEntries(new FormData(form).entries());
    const response = await fetch("/api/contacts", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ ...payload, festival_id: festivalId })
    });
    const result = await response.json();
    if (!response.ok) {
      setStatus(result.error || "No se pudo guardar");
      return;
    }
    setStatus("Contacto añadido. Recarga la página para verlo.");
    form.reset();
  }

  return (
    <form className="card grid" onSubmit={onSubmit}>
      <div>
        <p className="eyebrow">Contacto</p>
        <h2>Añadir responsable</h2>
      </div>
      <div className="form-grid">
        <input className="input" name="name" placeholder="Nombre" required />
        <input className="input" name="role" placeholder="Cargo: marketing, patrocinios..." />
        <input className="input" name="company" placeholder="Empresa / promotora" />
        <input className="input" name="email" placeholder="Email" />
        <input className="input" name="phone" placeholder="Teléfono" />
        <input className="input" name="instagram" placeholder="Instagram" />
        <select className="select" name="legal_basis" defaultValue="contacto profesional público">
          <option>contacto profesional público</option>
          <option>relación previa</option>
          <option>consentimiento</option>
          <option>referido</option>
          <option>pendiente de validar</option>
        </select>
        <input className="input" name="source" placeholder="Fuente: web, LinkedIn, referido..." />
        <textarea className="textarea full" name="notes" placeholder="Notas internas" />
      </div>
      <div className="actions">
        <button className="btn green" type="submit">Añadir contacto</button>
        {status ? <span className="muted">{status}</span> : null}
      </div>
    </form>
  );
}
