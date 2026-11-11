# Seats That Know You — shared project website

## What's included
- `index.html` — responsive project presentation with in-page editing.
- `archive.md` — complete project archive supplied by the team.
- `presentation-2026-11-11.pdf` — this week's presentation.
- `setup.sql` — shared editing database setup for Supabase.

## Publish the website
1. Create a free site in Netlify (or another static host).
2. Drag the entire `seats-that-know-you-site` folder into Netlify Drop.
3. Keep all four files together. The site reads `archive.md` and links to the PDF beside `index.html`.

## Enable shared editing (one-time setup)
This is needed for edits to sync between different people/devices. Without it, browser edits are saved only on that device.

1. Create a Supabase project at https://supabase.com/.
2. In Supabase, open **SQL Editor** and open the included `setup.sql`.
3. Replace `YOUR_LONG_EDITOR_KEY` in the SQL with a long random secret (at least 32 characters). Run the SQL.
4. In Supabase **Project Settings → API**, copy the Project URL and anon/publishable key.
5. Open the deployed site → **Shared editing**. Paste the Project URL, anon key, and the exact same editor key. Save connection.
6. The first connection creates the initial shared page data. The page will then load shared edits from the database and check for updates every few seconds.

## Give edit permission
- View-only link: the normal website URL.
- Editor link: `https://YOUR-SITE.netlify.app/#edit=YOUR_LONG_EDITOR_KEY`
- Share the editor link only with people who should be able to edit. Anyone with this link can edit the page.
- Each editor opens the link, then uses **Save changes**. Changes sync to everyone using the same connected database.

## Editing
- Click **Edit site** and edit the highlighted text directly.
- Click **+ Add update** to add a dated team update.
- Click **Save changes** to publish.
- Use **Cancel** to discard unsaved text edits.
- The full archive is included in the Archive section and can be downloaded. The PDF link opens the 11 November presentation.

## Important notes
- The Supabase URL and anon key are public client-side values; the editor key is the permission secret.
- The editor key is present in the editor URL fragment. Do not post that link publicly.
- Keep a private copy of the editor key. If it is exposed, rotate it by updating the hash in `private.project_edit_secrets` using the SQL editor, then issue a new editor link.
- This is a first working version: it edits text content and adds project log entries; it does not yet provide a full visual block/page builder or simultaneous character-level co-editing. Changes are shared after Save, with periodic refresh for other viewers.
