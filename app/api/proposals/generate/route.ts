import { NextResponse } from "next/server";
import OpenAI from "openai";
import { createServiceClient, hasSupabaseEnv } from "@/lib/supabase/service";
import type { Contact, FestivalOverview } from "@/lib/types";

function fallbackProposal(festival: FestivalOverview, contact: Contact | undefined, channel: string, objective: string) {
  const name = contact?.name ? ` ${contact.name}` : "";
  const city = festival.city ? ` en ${festival.city}` : "";
  const stage = festival.sales_stage || festival.lifecycle_stage || "vuestra próxima edición";

  if (channel === "instagram") {
    return {
      subject: null,
      body: `Hola${name} 👋 Somos el equipo de @fiestas_es. Hemos visto que ${festival.name}${city} está en fase de ${stage}.\n\nCreemos que puede encajar una colaboración de contenido para dar visibilidad al festival antes de la fecha y mover conversación entre público joven interesado en planes, música y ocio.\n\n¿Quién lleva marketing o colaboraciones para pasarle una propuesta breve?`
    };
  }

  if (channel === "whatsapp") {
    return {
      subject: null,
      body: `Hola${name}, soy [TU NOMBRE] de @fiestas_es.\n\nTe escribo por ${festival.name}. Hemos visto que estáis en fase de ${stage} y quería proponerte una colaboración de contenido y difusión para esta edición.\n\n¿Te puedo enviar una idea resumida por aquí o prefieres que te la mande por email?`
    };
  }

  if (channel === "call") {
    return {
      subject: "Guion de llamada",
      body: `Apertura: Hola${name}, soy [TU NOMBRE] de @fiestas_es. Te llamo por ${festival.name}, porque creemos que puede tener sentido una colaboración de contenido con vosotros.\n\nContexto: Hemos visto que el festival está en fase de ${stage}${city}.\n\nPropuesta: Podemos preparar una activación de contenido previa al festival: reels, stories, cobertura, sorteos o difusión segmentada.\n\nCierre: ¿Quién es la persona adecuada para valorar colaboraciones o campañas de marketing? ¿Te parece si envío una propuesta breve hoy?`
    };
  }

  return {
    subject: `Propuesta de colaboración para ${festival.name}`,
    body: `Hola${name},\n\nSomos el equipo de @fiestas_es. Hemos visto que ${festival.name}${city} está en fase de ${stage} y creemos que puede tener sentido explorar una colaboración de contenido y difusión para esta edición.\n\nNuestra idea sería preparar una campaña sencilla y visual enfocada en público que consume festivales, música y ocio en España, con formatos adaptados a Instagram y contenido previo al festival.\n\nPodemos aterrizarlo en una propuesta breve con formatos, calendario y opciones de colaboración.\n\n¿Te encajaría que te enviemos una idea más concreta esta semana?\n\nUn saludo,\n[Tu nombre]\n@fiestas_es`
  };
}

export async function POST(request: Request) {
  const body = await request.json();
  const festival = body.festival as FestivalOverview;
  const contacts = (body.contacts || []) as Contact[];
  const contact = contacts.find((item) => item.id === body.contact_id);
  const channel = body.channel || "email";
  const objective = body.objective || "colaboración de contenido";

  let generated = fallbackProposal(festival, contact, channel, objective);

  if (process.env.OPENAI_API_KEY) {
    const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });
    const prompt = `
Eres responsable comercial de @fiestas_es. Genera una propuesta breve y personalizable.

Festival: ${festival.name}
Ciudad: ${festival.city || "pendiente"}
Fechas: ${festival.start_date || "pendiente"} a ${festival.end_date || "pendiente"}
Tramo/fase: ${festival.sales_stage || festival.lifecycle_stage || "pendiente"}
Asistencia estimada: ${festival.expected_attendance || festival.avg_attendance || "pendiente"}
Contacto: ${contact?.name || "sin contacto concreto"}
Cargo: ${contact?.role || "pendiente"}
Canal: ${channel}
Objetivo: ${objective}

Reglas:
- No inventes datos.
- Si falta un dato, no lo menciones o marca [dato pendiente].
- Para WhatsApp e Instagram, hazlo corto y natural.
- Para email, incluye asunto y cuerpo.
- Devuelve JSON con subject y body.
`;

    const response = await openai.chat.completions.create({
      model: "gpt-4o-mini",
      messages: [
        { role: "system", content: "Genera textos comerciales claros, breves, profesionales y naturales en español de España." },
        { role: "user", content: prompt }
      ],
      response_format: { type: "json_object" },
      temperature: 0.65
    });

    const content = response.choices[0]?.message?.content;
    if (content) {
      try {
        const parsed = JSON.parse(content);
        generated = { subject: parsed.subject || null, body: parsed.body || generated.body };
      } catch {
        generated = { subject: generated.subject, body: content };
      }
    }
  }

  if (body.save && hasSupabaseEnv()) {
    const supabase = createServiceClient();
    await supabase.from("proposals").insert({
      festival_id: festival.festival_id,
      contact_id: contact?.id || null,
      channel,
      objective,
      subject: generated.subject,
      body: generated.body,
      status: "draft",
      ai_model: process.env.OPENAI_API_KEY ? "openai" : "fallback-template",
      prompt_version: "v1"
    });
  }

  return NextResponse.json(generated);
}
