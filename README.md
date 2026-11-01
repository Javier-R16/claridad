# Claridad

Test de señales (14 preguntas). Una sola página estática: `index.html`.
No accede ni espía ningún dispositivo; solo usa lo que la persona responde.

## Puesta en marcha
1. **Supabase**: crea un proyecto, abre *SQL Editor* y ejecuta `supabase.sql`.
   Copia *Project URL* y la clave **anon public** (Settings > API). Nunca uses la `service_role`.
2. **Repo y Pages**: crea el repo en GitHub, sube estos archivos y activa *Settings > Pages > Deploy from branch: main / root*.
   La URL será `https://TU_USUARIO.github.io/NOMBRE_REPO/`.
3. **Configura** (reemplaza los placeholders `__SITE_URL__`, `__SUPABASE_URL__`, `__SUPABASE_ANON_KEY__`):
   `node configure.mjs https://TU_USUARIO.github.io/NOMBRE_REPO/ https://xxxx.supabase.co TU_ANON_KEY`
   y haz commit/push.
4. **Open Graph**: pega la URL en <https://developers.facebook.com/tools/debug/> para refrescar la caché de WhatsApp.

## Datos
- `waitlist(email)`: correos de la lista de espera. Solo se puede insertar desde el navegador.
- `quiz_completions(level, score)`: contador anónimo. Sin respuestas, IP ni identificadores.
- Consulta resultados en el panel de Supabase: `select * from completions_by_level;`
