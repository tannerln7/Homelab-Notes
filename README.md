# Personal Documentation

This repository is a private technical notebook for homelab, infrastructure, services, applications, hardware, networking, automation, and scripts. The goal is to keep exact paths, service names, commands, timers, and operational notes in one place so they are easy to recover later.

## Local setup

Create a virtual environment and install the site dependencies:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

## Preview locally

Run the live preview server from the repository root:

```bash
mkdocs serve
```

The default preview URL is `http://127.0.0.1:8000/`.

## Build the site

Build the static site into `site/`:

```bash
mkdocs build --strict
```

## Deploy with GitHub Pages

This repository includes a GitHub Actions workflow at `.github/workflows/deploy-pages.yml`.

To use it:

1. Push the repository to GitHub.
2. In the repository settings, open Pages.
3. Set the source to GitHub Actions.
4. Push to the repository's default branch or run the workflow manually.

The workflow builds the MkDocs site and deploys the generated `site/` directory to GitHub Pages.

## Add a new documented item

1. Pick the best category under `docs/`.
2. Create a lowercase, hyphen-separated folder for the item.
3. Start from the templates in `docs/templates/`.
4. Add the new pages to `mkdocs.yml` navigation.
5. Update the item's `changes.md` when the page reflects a meaningful real-world change.

## Secret handling

Do not commit passwords, API keys, private keys, recovery codes, tokens, or other secrets. If a note needs to mention a credential, document the file path and key name only, and redact the value.