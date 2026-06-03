export const dynamic = "force-dynamic";
export const revalidate = 0;

import { Shell } from "@/components/Shell";
import { ContactList } from "@/components/ContactList";
import { getContacts } from "@/lib/data";

export default async function ContactsPage() {
  const contacts = await getContacts();

  return (
    <Shell>
      <div className="topbar">
        <div>
          <p className="eyebrow">CRM</p>
          <h1>Contactos responsables</h1>
          <p className="muted">Responsables de marketing, patrocinios, prensa, promotoras y agencias.</p>
        </div>
      </div>

      <div className="table-wrap card" style={{ padding: 0 }}>
        <table>
          <thead>
            <tr><th>Nombre</th><th>Cargo</th><th>Empresa</th><th>Email</th><th>Teléfono</th><th>Instagram</th><th>Base legal</th></tr>
          </thead>
          <tbody>
            {contacts.map((contact) => (
              <tr key={contact.id}>
                <td>{contact.name}</td>
                <td>{contact.role || "—"}</td>
                <td>{contact.company || "—"}</td>
                <td>{contact.email || "—"}</td>
                <td>{contact.phone || "—"}</td>
                <td>{contact.instagram || "—"}</td>
                <td>{contact.legal_basis || "pendiente"}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <div style={{ marginTop: 24 }}>
        <ContactList contacts={contacts.slice(0, 6)} />
      </div>
    </Shell>
  );
}
