<div align="center">

# 🌀 vibe-builder

### turn a vague idea into a buildable plan — without speaking engineer

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](./LICENSE)
[![Claude Code Skill](https://img.shields.io/badge/Claude_Code-Skill-D97757)](https://docs.claude.com/en/docs/claude-code/skills)
[![Made for Vibe Coders](https://img.shields.io/badge/made_for-vibe_coders-blueviolet)]()
[![Built on the shoulders of giants](https://img.shields.io/badge/credits-3_OSS_projects-orange)](./CREDITS.md)

</div>

---

> *"i wanna build a website where indie devs can post their games and players leave reviews"*

That's all you need to say. vibe-builder takes it from there.

## ✨ what happens

````
you      → "i have an idea for an app that helps me track my forex trades better"
                                    ↓
vibe-builder fires automatically:
                                    ↓
  📝 captures + expands the idea into a real spec
  🔍 searches for existing open-source projects you can fork
  🏗️  picks the stack (Next.js? Supabase? decided, not asked)
  🔌 walks you through any setup with exact button names + URLs
  📋 outputs phases — each with concrete deliverables you can test
  🛡️  auto-reviews each phase for bugs, UX gaps, security holes
  🎨 hands UI/UX work to the bundled design intelligence engine
                                    ↓
you      → "ready" → it ships working code
````

No jargon. No 6-question forms. No "what's your tech stack?" — that's the skill's job, not yours.

---

## 🎯 who this is for

| If you... | vibe-builder is for you |
|-----------|------------------------|
| Have ideas but freeze when someone says "what database?" | ✅ |
| Want to build real products, not toy demos | ✅ |
| Already know React/Next.js/Postgres deeply | maybe — try [gstack](https://github.com/garrytan/gstack) instead |
| Want Claude to ask 12 clarifying questions before doing anything | ❌ wrong skill, sorry |
| Need persistent memory across sessions | ✅ pairs with [claude-mem](https://github.com/thedotmack/claude-mem) |

---

## 🚀 install

This is a [Claude Code skill](https://docs.claude.com/en/docs/claude-code/skills). It runs inside Claude Code on your machine.

```bash
git clone https://github.com/helldock0/vibe-builder.git ~/.claude/skills/vibe-builder
```

That's it. Open Claude Code, describe what you want to build, and vibe-builder activates automatically.

### 🧰 recommended companions

| Tool | What it does | Install |
|------|--------------|---------|
| 🧠 [**claude-mem**](https://github.com/thedotmack/claude-mem) | Persistent memory across sessions | `npx claude-mem install` |
| 📊 **statusline** | Per-model usage display in your terminal | Ships with this skill — see [SKILL.md](./SKILL.md) |

---

## 🎬 a real example

You: 
> *yo i wanna make a tool for valorant coaches that can analyze opponent team comps faster*

vibe-builder:
> Got it — Valorant opponent comp analyzer for coaches. Quick check: pulling data from rib.gg or directly from VOD frames?
>
> *(after you answer "rib.gg")*
>
> Here's what I'm building toward:
> - Comp analyzer for Valorant team coaches
> - Core: paste opponent IDs → fetch agent history → flag patterns
> - Must-have: comp breakdown + most-played agents per player  
> - Nice-to-have: meta drift charts, side-pick stats
>
> Searching for existing tools first...

*(...moves through phases automatically, picks Next.js + Supabase, walks you through Supabase setup with exact buttons, ships Phase 1 working...)*

> ✅ Phase 1 done.  
> Built: signup, dashboard with empty state, sign-out.  
> Auto-fixed: 2 — middleware naming, font binding.  
>
> Ready for Phase 2 — paste opponent IDs?

That's the whole vibe. Decisive, plain English, ships things.

---

## 🧱 what's inside

````
vibe-builder/
├── SKILL.md              # the brain — 6-phase workflow
├── CREDITS.md            # full attribution
├── LICENSE               # MIT
├── bin/
│   └── statusline.sh     # per-model usage + context + cost display
└── bundled/
    └── ui-ux-pro-max/    # design intelligence engine (MIT, bundled in full)
````

---

## 🙏 credits

vibe-builder stands on the shoulders of three excellent open-source projects:

| Project | What it gave us | License |
|---------|-----------------|---------|
| 🎨 [**UI UX Pro Max**](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) by nextlevelbuilder | Bundled in full as the design intelligence engine | MIT |
| 🏗️ [**gstack**](https://github.com/garrytan/gstack) by Garry Tan / Y Combinator | Multi-role workflow patterns borrowed | MIT |
| 🧠 [**claude-mem**](https://github.com/thedotmack/claude-mem) by thedotmack | Recommended companion, orchestrated alongside | Apache 2.0 |

Massive thanks to all three. Full attribution in [CREDITS.md](./CREDITS.md).

---

## 📜 license

[MIT](./LICENSE) — free forever. Fork it, improve it, make it yours. I'm not trying to earn anything from this — just doing good things, I guess.

---

<div align="center">

Built by [James](https://github.com/helldock0) ([@Helldock](https://github.com/helldock0))

⭐ if this saved you from "what stack should I use?" paralysis, throw a star

</div>
