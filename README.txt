MovI — Team A website package

FILES
- index.html: the new scroll-based MovI presentation website.
- prototype.html: the existing interactive face-recognition / seat-personalisation prototype, embedded in the website and also available as a standalone page.

PUBLISH ON GITHUB PAGES
1. Unzip this package.
2. Open your existing GitHub repository.
3. Upload the CONTENTS of this folder to the repository root (not the folder itself).
4. Replace the existing index.html and add/replace prototype.html.
5. Commit the changes. Keep GitHub Pages set to main / (root).
6. Wait for the Pages deployment, then hard-refresh the public website (Cmd+Shift+R).

EDITING
- Click “Edit content” at the bottom-right to edit headlines, paragraphs, labels and other text directly on the site.
- Save stores those edits in the current browser only.
- Use Export to create a JSON file and send it to teammates. They can use Import on their browser to apply the same text edits.
- This is not yet real-time multi-user editing. That requires a shared backend/database connection.

NEUE MACHINA
The website requests “Neue Machina” for headings. The font is commercial and is not bundled in this package. To display it consistently for all visitors, obtain the appropriate webfont licence from Pangram Pangram and place the licensed WOFF2 file at fonts/neue-machina.woff2. The CSS is already configured to load that path. If the font is installed locally, the site will use it automatically; otherwise it falls back to Arial.

PROTOTYPE NOTE
The embedded prototype requests camera access through the browser. Use the public HTTPS GitHub Pages URL and allow camera permission. Recognition and other prototype functions depend on the included prototype's external model/library availability and browser support. The surrounding MovI website itself does not claim to be a production vehicle system.
