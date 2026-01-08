# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a hand-crafted static personal portfolio website hosted on GitHub Pages at **rudzainy.com**. It uses pure HTML with Bootstrap via CDN—no build system, no static site generator.

## Technology Stack

- **HTML5** - Semantic markup, no templating
- **Bootstrap 5.3.8** - CDN-hosted for layout and responsive design
- **Bootstrap Icons 1.13.1** - CDN-hosted icon library
- **Custom CSS** - `si-es-es.css` for house styles (card hover effects, shadows, transitions)
- **Vanilla JavaScript** - `jei-es.js` for quote randomization on section pages

## Development Workflow

There is no build step. Edit files directly and push to GitHub:

```bash
# View locally - open any HTML file in browser or use a local server
python3 -m http.server 8000

# Deploy - push to main branch, GitHub Pages serves automatically
git push origin main
```

## Site Architecture

```
/                       # Root HTML pages (index.html)
├── /work/              # Portfolio items (49 entries, 2008-2025)
├── /life/              # Personal/lifestyle content (35 entries)
├── /balance/           # Wellness content (87 entries)
├── /components/        # Reusable UI component library/reference
│   ├── /cards/         # Card variants (1x1, 2x2, featured, quote, etc.)
│   ├── /grids/         # Grid layout patterns
│   └── /modals/        # Modal component snippets
├── /images/            # All image assets
│   ├── /portfolio/     # Portfolio images organized by project
│   └── /posts/         # Blog/post images
└── /docs/              # PDF/document assets (CVs, portfolios)
```

## Content Pattern

Content items follow a date-based naming convention:

```
YYYY-MM-DD-slug-title.html   # Served HTML file
YYYY-MM-DD-slug-title.md     # Optional markdown source (converted offline)
```

Both `.md` and `.html` versions may exist. The HTML files are what GitHub Pages serves.

## Key Files

| File | Purpose |
|------|---------|
| `index.html` | Homepage with Bootstrap grid layout |
| `si-es-es.css` | Custom styles: card hover effects, shadows, responsive helpers |
| `jei-es.js` | Quote randomizer script for section pages |
| `CNAME` | Custom domain configuration (rudzainy.com) |
| `/components/index.html` | UI component catalog/documentation |

## Styling Conventions

The site uses Bootstrap classes extensively. Custom CSS in `si-es-es.css` adds:
- Text shadows on headings (h1, h2)
- Card hover: translateY(-5px) lift effect with shadow
- Image hover: scale(1.02) zoom effect
- Custom button shadows and transitions
- 150px × 150px base card size

## JavaScript Notes

`jei-es.js` contains three quote arrays (`quotesWork`, `quotesLife`, `quotesBalance`) that rotate random quotes every 4-6 seconds on respective section cards.

## EditorConfig

The project enforces:
- LF line endings
- UTF-8 charset
- 2-space indentation
- Trim trailing whitespace (except in .md files)
