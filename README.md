# Evan's Coding Agent Blog

This repository hosts Evan Oman's Jekyll-powered blog about software engineering and coding agents. It uses the [Minimal Mistakes](https://github.com/mmistakes/minimal-mistakes) remote theme with the dark skin and deploys via GitHub Pages.

## Prerequisites

1. Install Ruby 3.3 via Homebrew:
   ```bash
   brew install ruby@3.3
   ```
2. Add Ruby to your shell (consider adding this to `~/.zshrc`):
   ```bash
   export PATH="/opt/homebrew/opt/ruby@3.3/bin:$PATH"
   ```
3. Install Bundler and project gems:
   ```bash
   gem install bundler
   bundle install
   ```

## Local development

- `bin/dev` (default) – runs `bundle exec jekyll serve --livereload`
- `bin/dev build` – runs `bundle exec jekyll build`
- `bin/dev doctor` – runs `bundle exec jekyll doctor`

The site will be available at `http://127.0.0.1:4000` with live reload.

## Writing posts

See `docs/authoring.md` for filename conventions, required front matter, and tag guidance.

## Deployment

GitHub Actions (`.github/workflows/pages.yml`) builds the site with Jekyll on every push to `main` and deploys it to the GitHub Pages environment. You only need to wire the repository to Pages in the repo settings and optionally add a custom domain.

## Q&A

- **Change the theme skin?** Update `minimal_mistakes_skin` in `_config.yml` to any supported skin (`dark`, `neon`, `contrast`, etc.).
- **Switch to a different theme later?** Point `remote_theme` at another public Jekyll theme and update any theme-specific configuration.
- **Where do author details live?** In `_data/authors.yml`. Update the `evan_oman` entry or add more authors.
