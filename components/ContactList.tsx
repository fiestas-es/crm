import type { Contact } from "@/lib/types";

export function ContactList({ contacts }: { contacts: Contact[] }) {
  if (!contacts.length) {
    return (
      <div className="card">
        <p className="muted">Todavía no hay responsables asociados a este festival.</p>
        <p className="soft">Añade aquí marketing, patrocinios, prensa, dirección, producción, ticketing o agencia externa.</p>
      </div>
    );
  }

  return (
    <div className="grid">
      {contacts.map((contact) => (
        <article className="card" key={contact.id}>
          <div className="card-top">
            <div>
              <h3>{contact.name}</h3>
              <p className="muted">{contact.responsibility || contact.role || "Responsabilidad pendiente"} · {contact.company || "Empresa pendiente"}</p>
            </div>
            {contact.do_not_contact ? <span className="badge red">No contactar</span> : <span className="badge green">Contactable</span>}
          </div>
          <div className="actions" style={{ marginBottom: 12 }}>
            <span className="badge purple">{contact.priority ? `Prioridad ${contact.priority}` : "Prioridad media"}</span>
            <span className="badge blue">{contact.relationship_status || "nuevo"}</span>
            {contact.owner_name ? <span className="badge">Lleva {contact.owner_name}</span> : null}
          </div>
          <div className="kv">
            <div><span>Email</span><strong>{contact.email || "—"}</strong></div>
            <div><span>Teléfono / WhatsApp</span><strong>{contact.phone || "—"}</strong></div>
            <div><span>Instagram</span><strong>{contact.instagram || "—"}</strong></div>
            <div><span>Base legal</span><strong>{contact.legal_basis || "pendiente"}</strong></div>
          </div>
          {contact.notes ? <p className="muted" style={{ marginTop: 14 }}>{contact.notes}</p> : null}
        </article>
      ))}
    </div>
  );
}
