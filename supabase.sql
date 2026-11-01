-- Ejecuta esto en Supabase > SQL Editor.
-- El público (anon) solo puede INSERTAR. Nadie puede leer ni modificar desde el navegador.

create table if not exists public.waitlist (
  id         bigint generated always as identity primary key,
  email      text not null check (length(email) <= 254 and email ~* '^[^@\s]+@[^@\s]+\.[^@\s]{2,}$'),
  created_at timestamptz not null default now()
);
create unique index if not exists waitlist_email_key on public.waitlist (lower(email));

create table if not exists public.quiz_completions (
  id         bigint generated always as identity primary key,
  level      text not null check (level in ('Calma','Señales leves','Señales claras','Alerta alta')),
  score      int  not null check (score between 0 and 100),
  created_at timestamptz not null default now()
);

alter table public.waitlist         enable row level security;
alter table public.quiz_completions enable row level security;

drop policy if exists "anon insert waitlist" on public.waitlist;
create policy "anon insert waitlist" on public.waitlist
  for insert to anon with check (true);

drop policy if exists "anon insert completions" on public.quiz_completions;
create policy "anon insert completions" on public.quiz_completions
  for insert to anon with check (true);

revoke all on public.waitlist, public.quiz_completions from anon, authenticated;
grant insert on public.waitlist, public.quiz_completions to anon;

-- Vista para ti (desde el panel de Supabase): terminados por nivel
create or replace view public.completions_by_level as
  select level, count(*) as total, round(avg(score)) as avg_score
  from public.quiz_completions group by level order by total desc;
revoke all on public.completions_by_level from anon, authenticated;
