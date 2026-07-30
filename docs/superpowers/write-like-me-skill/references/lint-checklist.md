# Lint checklist

Run the deterministic greps first, then read for the soft tells.

## Deterministic (run these)

Em-dash (must be zero hits in his copy):
```bash
grep -nP '\x{2014}' <file(s)>
```

twitter.com rewritten to x.com (must be zero hits):
```bash
grep -nE '\bx\.com\b' <file(s)>
```

Report every line number returned. These are hard-rule violations.

## Soft tells (read and judge)

- **STE / robotic flattening:** copy stripped of personality, all sentences the
  same length, no asides. His voice is not this.
- **Generic AI tells:** "delve", "moreover", "furthermore", "it's not just X,
  it's Y", "in today's fast-paced world", over-tidy rule-of-three lists, hollow
  hedging ("it's worth noting that").
- **Lost code-switch:** Malay that got translated out to plain English where he
  would have kept it.
- **Emoji overuse:** emoji on nearly every line, or as decoration rather than
  accent.
- **Marketing gloss:** superlatives and pitch language in place of his plain,
  slightly wry framing.

For each soft tell found, quote the offending text and name the tell. Do not
auto-fix unless asked.
