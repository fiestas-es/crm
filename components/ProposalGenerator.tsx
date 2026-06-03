"use client";

import { useState } from "react";
import type { FestivalOverview, Contact } from "@/lib/types";

export function ProposalGenerator({ festival, contacts }: { festival: FestivalOverview; contacts: Contact[] }) {
  const [channel, setChannel] = useState("email");
  const [objective, setObjective] = useState("colaboración de contenido y difusión");
  const [contactId, setContactId] = useState(contacts[0]?.id || "");
  const [loading, setLoading] = useState(false);
  const [result, setResult] = useState<{ subject?: string; body: string } | null>(null);
  const [error, setError] = useState<string | null>(null);

  async function generate() {
    setLoading(true);
    setError(null);
    setResult(null);

    const response = await fetch("/api/proposals/generate", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ festival, contact_id: contactId || null, contacts, channel, objective, save: true })
    });
    const data = await response.json();
    setLoading(false);
    if (!response.ok) {
      setError(data.error || "No se pudo generar la propuesta");
      return;
    }
    setResult({ subject: data.subject, body: data.body });
  }

  return (
    <section className="card grid">
      <div>
        <p className="eyebrow">IA comercial</p>
        <h2>Generador de propuesta</h2>
        <p className="muted">Genera un borrador adaptado al canal. No envía nada automáticamente.</p>
      </div>

      <div className="form-grid">
        <select className="select" value={channel} onChange={(e) => setChannel(e.target.value)}>
          <option value="email">Email</option>
          <option value="instagram">Instagram DM</option>
          <option value="whatsapp">WhatsApp</option>
          <option value="call">Guion de llamada</option>
        </select>
        <select className="select" value={contactId} onChange={(e) => setContactId(e.target.value)}>
          <option value="">Sin contacto concreto</option>
          {contacts.map((contact) => <option key={contact.id} value={contact.id}>{contact.name} · {contact.role || "contacto"}</option>)}
        </select>
        <input className="input full" value={objective} onChange={(e) => setObjective(e.target.value)} placeholder="Objetivo" />
      </div>

      <div className="actions">
        <button className="btn primary" type="button" onClick={generate} disabled={loading}>
          {loading ? "Generando..." : "Generar propuesta"}
        </button>
        {error ? <span className="error">{error}</span> : null}
      </div>

      {result ? (
        <div className="card" style={{ background: "rgba(0,0,0,.18)" }}>
          {result.subject ? <><strong>Asunto</strong><p>{result.subject}</p></> : null}
          <strong>Texto</strong>
          <textarea className="textarea" value={result.body} readOnly style={{ minHeight: 260 }} />
        </div>
      ) : null}
    </section>
  );
}
