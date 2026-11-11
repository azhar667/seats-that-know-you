-- Seats That Know You — shared editing setup (Supabase)
-- 1) Replace YOUR_LONG_EDITOR_KEY below with a long random secret.
-- 2) Run this whole script in Supabase > SQL Editor.
-- 3) Enter the same key in the website's Shared editing settings.
create extension if not exists pgcrypto;
create table if not exists public.project_site_content (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz not null default now()
);
alter table public.project_site_content enable row level security;

create schema if not exists private;
create table if not exists private.project_edit_secrets (
  id text primary key,
  secret_hash text not null
);
revoke all on schema private from public, anon, authenticated;
revoke all on private.project_edit_secrets from public, anon, authenticated;

insert into private.project_edit_secrets(id, secret_hash)
values ('team-a', encode(digest('YOUR_LONG_EDITOR_KEY', 'sha256'), 'hex'))
on conflict (id) do update set secret_hash = excluded.secret_hash;

create or replace function public.can_edit_team_a()
returns boolean
language sql
security definer
set search_path = public, private, extensions
as $$
  select coalesce(
    encode(digest(
      coalesce((current_setting('request.headers', true)::jsonb ->> 'x-edit-key'), ''),
      'sha256'
    ), 'hex') = (select secret_hash from private.project_edit_secrets where id = 'team-a'),
    false
  );
$$;
revoke all on function public.can_edit_team_a() from public;
grant execute on function public.can_edit_team_a() to anon, authenticated;

drop policy if exists "Public can read project page" on public.project_site_content;
create policy "Public can read project page"
on public.project_site_content for select
to anon, authenticated using (true);

drop policy if exists "Editors can insert project page" on public.project_site_content;
create policy "Editors can insert project page"
on public.project_site_content for insert
to anon, authenticated with check (public.can_edit_team_a());

drop policy if exists "Editors can update project page" on public.project_site_content;
create policy "Editors can update project page"
on public.project_site_content for update
to anon, authenticated using (public.can_edit_team_a()) with check (public.can_edit_team_a());

grant select, insert, update on public.project_site_content to anon, authenticated;
