// Uso: node configure.mjs <SITE_URL> <SUPABASE_URL> <SUPABASE_ANON_KEY>
// Ej:  node configure.mjs https://usuario.github.io/claridad/ https://xxxx.supabase.co eyJ...
import { readFileSync, writeFileSync } from "node:fs";
const [site, sbUrl, sbKey] = process.argv.slice(2);
if (!site || !sbUrl || !sbKey) { console.error("Faltan argumentos. Ver README."); process.exit(1); }
if (!site.endsWith("/")) { console.error("SITE_URL debe terminar en /"); process.exit(1); }
let s = readFileSync("index.html", "utf8");
s = s.replaceAll("__SITE_URL__", site).replaceAll("__SUPABASE_URL__", sbUrl).replaceAll("__SUPABASE_ANON_KEY__", sbKey);
writeFileSync("index.html", s);
console.log("index.html configurado.");
