-- Run this AFTER the original setup.sql has been run successfully.
-- It creates a public-read bucket for PDF presentations and restricts write access
-- to visitors who send the same x-edit-key used by the site's shared editor.

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('presentations', 'presentations', true, 52428800, array['application/pdf'])
on conflict (id) do update set
  public = true,
  file_size_limit = 52428800,
  allowed_mime_types = array['application/pdf'];

drop policy if exists "Public can read presentation PDFs" on storage.objects;
create policy "Public can read presentation PDFs"
on storage.objects for select
to anon, authenticated
using (bucket_id = 'presentations');

drop policy if exists "Editors can upload presentation PDFs" on storage.objects;
create policy "Editors can upload presentation PDFs"
on storage.objects for insert
to anon, authenticated
with check (bucket_id = 'presentations' and public.can_edit_team_a());

drop policy if exists "Editors can update presentation PDFs" on storage.objects;
create policy "Editors can update presentation PDFs"
on storage.objects for update
to anon, authenticated
using (bucket_id = 'presentations' and public.can_edit_team_a())
with check (bucket_id = 'presentations' and public.can_edit_team_a());

drop policy if exists "Editors can delete presentation PDFs" on storage.objects;
create policy "Editors can delete presentation PDFs"
on storage.objects for delete
to anon, authenticated
using (bucket_id = 'presentations' and public.can_edit_team_a());
