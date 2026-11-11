# Seats That Know You — Team A website

This version replaces the raw, pasted archive with an English editorial project archive organised into visual chapters. It also embeds the 11 November 2026 presentation in an in-page PDF slide viewer.

## Files to publish to GitHub Pages

Keep these files in the repository root:

- `index.html`
- `presentation-2026-11-11.pdf`
- `storage-setup.sql` (for Supabase presentation uploads)

The site no longer fetches or displays `archive.md`. You can remove the old Azerbaijani `archive.md` from the GitHub repository if you do not want that raw source file publicly accessible. The important project history has been translated, condensed and reorganised in the English Project Archive section inside the website.

## Update the existing GitHub Pages site

1. Open your `seats-that-know-you` GitHub repository.
2. Upload the new `index.html`, replacing the existing one.
3. Upload `storage-setup.sql` to the repository root.
4. Keep `presentation-2026-11-11.pdf` in the repository root. If it is already there, you do not need to upload it again.
5. Commit the changes. GitHub Pages will redeploy automatically.

## Enable presentation management (one-time Supabase step)

Your original Supabase shared-editing setup should already be in place. To let editors upload, replace and delete presentation PDFs:

1. Open the `storage-setup.sql` file in this folder.
2. Copy its complete contents.
3. In Supabase, open **SQL Editor → New query**.
4. Paste and run the script.

This creates a public-read `presentations` storage bucket. Upload, update and delete policies call the existing `public.can_edit_team_a()` function, which checks the same `x-edit-key` header as the site's shared editor. Do not rerun or change the original editor secret unless you intend to rotate it.

## How the website editor works

- Readers can view the site and the presentation library.
- Editors open the site using the shared editor link containing `#edit=YOUR_EDITOR_KEY`.
- Each editor device connects once using the Supabase Project URL, anon/publishable key and editor key.
- **Edit site** enables inline editing for the page copy and the English archive chapters.
- **Presentations** in the bottom editor bar opens the presentation manager.
- Editors can add a PDF, change a presentation's title/date/description, replace its PDF, or delete it.
- The original 11 November deck is served from the GitHub Pages repository. New and replaced PDFs are uploaded to Supabase Storage.
- Changes to the site content and presentation list are saved to the shared Supabase row and are polled by other visitors approximately every 7 seconds.

This is save-and-sync collaboration, not simultaneous Google Docs-style editing. Avoid editing the same item at the same time.

## Presentation viewer

The PDF is rendered in the page using PDF.js. Visitors can use Previous / Next, tap the numbered page strip, click the left/right sides of the slide, use keyboard arrow keys, or swipe on touch screens.

## Notes

- GitHub Pages hosts the static website; it does not provide the shared database.
- Supabase Free plan limits and inactivity policies can change. Check your dashboard for current usage and project status.
- The PDF viewer loads PDF.js from a CDN, so the first load requires an internet connection.
- The editor key is a shared secret. Share the editor URL only with teammates who should be able to make changes. Never put the key in a public repository or a public document.
