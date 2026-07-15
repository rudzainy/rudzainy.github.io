# ~|{·}) rudzainy.com

Hey 👋 This is my little corner of the internet — a hand-crafted personal
portfolio at **[rudzainy.com](https://rudzainy.com)**. I'm Rudzainy Rahman, a
Malaysian UI/UX designer and developer who also dabbles in theatre, photography,
and the occasional Ruby on Rails rabbit hole.

No framework, no build step, no fuss. Just HTML I write by hand, a sprinkle of
Bootstrap, and one CSS file doing the heavy lifting. If you can open a file in a
browser, you can run this whole site.

## The three sides of me

The homepage is a **bento grid** — mixed-size cards you can wander through. It's
split into three sections, each with its own colour so you always know where you
are:

- 🟦 **Work** (indigo) — the portfolio. Design, branding, UX, and the things I've
  built, from 2008 to now.
- 🟩 **Life** (emerald) — travel, books, games, the personal stuff.
- 🟧 **Balance** (saffron) — thoughts, reflections, a bit of creative writing, and
  dev notes I keep for myself.

Plus neutral white cards for everything in between.

## How it's built

- **Plain HTML5** — every page is a real file under `/`, `/work/`, `/life/`,
  `/balance/`. What you see in the repo is what GitHub Pages serves.
- **Bootstrap 5.3** + **Bootstrap Icons**, from a CDN.
- **`si-es-es.css`** — my house styles, driven by design tokens (see below).
- **`jei-es.js`** — a tiny script that rotates random quotes on the section cards.

There's **no static site generator**. You'll spot a pile of `.md` files next to
the `.html` ones under `work/`, `life/`, and `balance/` — those are **legacy
Jekyll sources** from an older life of this site. They're not built and not
served; I keep them as source material (and as the input for the knowledge
bundle further down). The `.html` files are the real, live site.

## Run it locally

```bash
# From the repo root — serve the folder and open http://localhost:8000
python3 -m http.server 8000
```

Or just double-click any `.html` file. That's it.

## Deploy

```bash
git push origin main
```

GitHub Pages does the rest. The custom domain lives in `CNAME`.

## The design system

The look has a name: **Batik** — indigo, emerald, and saffron on a warm songket
cream, with a rose accent. It's all captured as **design tokens** at the top of
`si-es-es.css` (`--color-*`, `--space-*`, `--type-*`, `--shadow-*`, `--motion-*`),
so changing one value updates the whole site.

There's a living style guide at **`components/design-system.html`** — palette,
type scale, spacing, shadows, and motion, all rendered straight from the tokens.
The wider component catalog sits at **`components/index.html`**.

Typography is **Unica One** (condensed uppercase) for headings and **Crimson
Text** (serif) for body and quotes, with a monospace logo — `~|{·})`, a little
wau kite.

## The knowledge bundle

Under **`.okf/`** there's an [Open Knowledge Format](https://github.com/GoogleCloudPlatform/knowledge-catalog)
bundle — one concept per post (82 of them), distilled from the cleaned sources
and cross-linked by theme (so Hoojah connects to its podcast and its ReactJS
notes, the DXC BioniX pieces link up, and so on). It's plain markdown, so both
people and agents can read it. Start at `.okf/index.md`.

## Layout

```
/                    # index.html, 404.html
├── work/            # portfolio pieces (.html served, .md are legacy sources)
├── life/            # personal / lifestyle
├── balance/         # thoughts, reflections, dev notes, creative writing
├── components/      # component catalog + design-system.html style guide
├── images/          # all assets (portfolio/ and posts/)
├── docs/            # PDFs, CVs, misc reference
└── .okf/            # Open Knowledge Format bundle
```

---

Made with care (and a lot of coffee ☕) by Rudzainy Rahman. Say hi if you're
building something — I'd love to hear about it.
