# CLAUDE.md

Guidance for Claude Code when working in this repository.

## Project Overview

Personal resume website for Paul Baker Sladek, built with Jekyll and hosted on GitHub Pages. Based on [jglovier/resume-template](https://github.com/jglovier/resume-template).

## Local Development

Uses Podman for local development:

```bash
make build    # first time or after Gemfile changes
make up       # start dev server → http://localhost:4000
make down     # stop
make restart  # restart after _config.yml changes
make logs     # follow logs
make shell    # bash session inside the container
make clean    # remove container, image, and volumes
```

File changes are picked up automatically via `--force_polling` (required for volume mounts on macOS). LiveReload runs on port 35729 and auto-refreshes the browser on save.

> Note: Run `make restart` after editing `_config.yml` — Jekyll only reads it at startup.

### Container details

- `Containerfile` — builds a `ruby:3.1` image, installs gems into the container (gems live at `/usr/local/bundle`, not in the project dir, so the volume mount doesn't clobber them)
- `compose.yml` — mounts the project directory into the container and exposes ports 4000 and 35729

## Architecture

- **Entry point**: `index.html` — 3 lines of front matter; applies the `resume` layout
- **All content**: Hardcoded in `_layouts/resume.html` (job entries, skills, education, summary)
- **Configuration**: `_config.yml` — controls site metadata, section visibility, and social links
- **Styles**: `_sass/*.scss` compiled via `css/main.scss` → `css/main.css`
- **Includes**: `_includes/head.html`, `_includes/icon-links.html`, `_includes/icons/*.html`

## Content Editing

Resume content lives directly in `_layouts/resume.html`, not in separate data files. To update:

- **Personal info / section toggles / social links** → `_config.yml`
- **Job entries, skills, education, summary text** → `_layouts/resume.html`

Sections can be toggled on/off via `resume_section_*` flags in `_config.yml`:
- `resume_section_experience`, `resume_section_education`, `resume_section_skills`
- `resume_section_recognition`, `resume_section_associations`, `resume_section_links`, `resume_section_projects`

## Deployment

Push to `main` → GitHub Actions builds Jekyll and deploys to GitHub Pages automatically (see `.github/workflows/jekyll.yml`). No manual steps needed.

## Dependencies

- `github-pages` gem (~> 232) — bundles Jekyll 3.10.0 and GitHub Pages-compatible plugins
- Ruby 3.1 (install with openssl@3 support via chruby — see README.md)

## Styling Notes

- SCSS variables and mixins: `_sass/_variables.scss`, `_sass/_mixins.scss`
- Resume-specific styles: `_sass/_resume.scss`
- Responsive breakpoint: 600px (`media_larger_than_mobile`)
- Font stack: Lora (serif) + Open Sans (sans-serif) from Google Fonts
