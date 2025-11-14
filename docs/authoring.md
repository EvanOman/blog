# Authoring Guide

This doc captures how to write Markdown posts for the blog so future you doesn’t have to remember the wiring.

## File locations

- Published posts live in `_posts/` and must follow `YYYY-MM-DD-slug.md` filenames.
- Drafts go in `_drafts/`. Run `JEKYLL_ENV=development bundle exec jekyll serve --drafts` (or `JEKYLL_ENV=development just serve -- --drafts`) to preview them locally.
- Standalone pages live in `_pages/` and can use any filename.

## Front matter schema

Posts and pages need YAML front matter at the top of the file so Jekyll and the Minimal Mistakes theme know how to render them.

```yaml
---
title: "Post Title"
date: 2025-11-14 09:00:00 -0800
summary: "Short one-liner for previews"
tags:
  - coding agents
  - workflows
categories:
  - lab-notes
author: evan_oman
agent_focus: evals           # optional, describe the agent angle
hero: /assets/images/hero.png # optional, large header image
canonical_url: https://example.com/post   # optional
---
```

Other helpful options supported by Minimal Mistakes defaults:

- `read_time: true|false` – override the automatic read-time badge.
- `toc: true|false` – toggle the in-page table of contents.
- `classes: wide` – use the wide content layout for diagrams.
- `last_modified_at: 2025-11-15` – surfaces an “updated” timestamp.

## Content tips

- Use `<!--more-->` in the body to mark the summary break for list pages.
- Embed code blocks with triple backticks and a language tag (` ```ruby `) for Rouge highlighting.
- Reference images with site-rooted paths (`/assets/images/...`). Keep assets under `assets/images/`.

## Metadata sources

- Author records live in `_data/authors.yml`. Add new keys for guest writers, then set `author: key` in their posts.
- Site-wide defaults (skin, pagination, nav) live in `_config.yml`.

## Preview + publish checklist

1. Run `just doctor` to catch broken links, missing front matter, or future-dated mistakes.
2. Run `just serve` and review the post locally.
3. Commit the Markdown file (and any assets) to the `main` branch.
4. Push to GitHub; Pages will rebuild automatically. Watch the “Pages build and deployment” workflow run for confirmation.
