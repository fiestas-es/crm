"use client";

import { useState } from "react";

export function AddContactForm({ festivalId }: { festivalId: string }) {
  const [status, setStatus] = useState<string | null>(null);

  async function onSubmit(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setStatus("Guardando responsable...");
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
    setStatus("Responsable añadido. Recarga la página para verlo.");
    form.reset();
  }

  return (
    <form className="card grid" onSubmit={onSubmit}>
      <div>
        <p className="eyebrow">Equipo del festival</p>
        <h2>Añadir responsable dentro de este festival</h2>
        <p className="muted">Este contacto quedará asociado solo a esta ficha de festival, aunque la persona pueda reutilizarse después en otros festivales.</p>
      </div>
      <div className="form-grid">
        <input className="input" name="name" placeholder="Nombre" required />
        <select className="select" name="responsibility" defaultValue="Marketing / campañas">
          <option>Dirección</option>
          <option>Marketing / campañas</option>
          <option>Patrocinios</option>
          <option>Prensa / comunicación</option>
          <option>Producción</option>
          <option>Ticketing</option>
          <option>Agencia externa</option>
          <option>Otro</option>
        </select>
        <input className="input" name="role" placeholder="Cargo exacto: Head of Marketing, PR Manager..." />
        <input className="input" name="company" placeholder="Empresa / promotora / agencia" />
        <input className="input" name="email" placeholder="Email" />
        <input className="input" name="phone" placeholder="Teléfono / WhatsApp" />
        <input className="input" name="instagram" placeholder="Instagram" />
        <input className="input" name="linkedin" placeholder="LinkedIn" />
        <select className="select" name="priority" defaultValue="alta">
          <option value="alta">Prioridad alta</option>
          <option value="media">Prioridad media</option>
          <option value="baja">Prioridad baja</option>
        </select>
        <select className="select" name="relationship_status" defaultValue="nuevo">
          <option value="nuevo">Nuevo</option>
          <option value="localizado">Localizado</option>
          <option value="contactado">Contactado</option>
          <option value="respondido">Respondido</option>
          <option value="reunión">Reunión</option>
          <option value="no contactar">No contactar</option>
        </select>
        <input className="input" name="owner_name" placeholder="Quién del equipo lo lleva" />
        <select className="select" name="legal_basis" defaultValue="contacto profesional público">
          <option>contacto profesional público</option>
          <option>relación previa</option>
          <option>consentimiento</option>
          <option>referido</option>
          <option>pendiente de validar</option>
        </select>
        <input className="input" name="source" placeholder="Fuente: web, LinkedIn, referido..." />
        <textarea className="textarea full" name="notes" placeholder="Notas internas: contexto, preferencia de canal, conversación previa..." />
      </div>
      <div className="actions">
        <button className="btn green" type="submit">Añadir responsable</button>
        {status ? <span className="muted">{status}</span> : null}
      </div>
    </form>
  );
}
