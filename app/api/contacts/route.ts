import { NextResponse } from "next/server";
import { createServiceClient, hasSupabaseEnv } from "@/lib/supabase/service";

export async function POST(request: Request) {
  if (!hasSupabaseEnv()) {
    return NextResponse.json({ error: "Configura Supabase para guardar contactos reales. Ahora estás en modo demo." }, { status: 400 });
  }

  const body = await request.json();
  const name = String(body.name || "").trim();
  if (!name) return NextResponse.json({ error: "Nombre requerido" }, { status: 400 });

  const supabase = createServiceClient();
  const { data: contact, error } = await supabase
    .from("contacts")
    .insert({
      name,
      role: body.role || null,
      company: body.company || null,
      email: body.email || null,
      phone: body.phone || null,
      instagram: body.instagram || null,
      linkedin: body.linkedin || null,
      source: body.source || "manual",
      legal_basis: body.legal_basis || "pendiente de validar",
      notes: body.notes || null
    })
    .select("*")
    .single();

  if (error) return NextResponse.json({ error: error.message }, { status: 500 });

  if (body.festival_id) {
    await supabase.from("festival_contacts").insert({
      festival_id: body.festival_id,
      contact_id: contact.id,
      responsibility: body.responsibility || body.role || "contacto",
      priority: body.priority || "media",
      relationship_status: body.relationship_status || "nuevo",
      owner_name: body.owner_name || null
    });
  }

  return NextResponse.json({ contact });
}
