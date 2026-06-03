import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Fiestas Radar",
  description: "CRM interno de festivales, contactos y propuestas para @fiestas_es"
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="es">
      <body>{children}</body>
    </html>
  );
}
