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

## 💭 why I built this

I'm not a software engineer. I trade forex, coach Valorant teams, and one day I'll take over my dad's business. Coding was never the plan.

Then Claude Code happened, and suddenly I could *actually build the things I'd been daydreaming about for years.* But every time I tried, I hit the same wall:

- Claude would ask *"what database do you want?"* — bro, I don't know, that's why I'm here
- I'd describe an idea and get back a 12-question form before any code happened
- Half the time it would build something from scratch when there was already a free open-source project that did 90% of the work
- I'd ship a Phase 1 with API keys exposed and no error handling, and only find out later when something broke

So I built vibe-builder. It's the skill I wish existed when I started.

It **decides instead of asking** (you can override anything). It **searches for existing solutions first** so you're not reinventing wheels. It **walks you through setup** with exact button names and URLs — not "go configure your Postgres instance." And it **silently reviews every phase** for the dumb mistakes a non-engineer would miss (exposed keys, missing auth, broken edge cases).

Built for people like me. If that's you too — welcome. 🌀

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

## 🛠️ install — step by step

> 📌 vibe-builder is a **Claude Code skill**. It runs inside [Claude Code](https://docs.claude.com/en/docs/claude-code) — Anthropic's terminal coding assistant. If you don't have Claude Code yet, install it first: https://docs.claude.com/en/docs/claude-code/installation

### 0. Prerequisites (one-time, ~5 minutes if you don't have these)

You need three things on your machine. Skip whichever ones you already have.

| Tool | Why | How to install |
|------|-----|----------------|
| **Claude Code** | Where the skill runs | https://docs.claude.com/en/docs/claude-code/installation |
| **Git** | To download the skill | Mac/Linux: usually pre-installed. Windows: https://git-scm.com/download/win |
| **Node.js 18+** | For the optional companion tools (claude-mem, statusline) | https://nodejs.org → download the LTS version |

To check if you already have them, open your terminal and run:

```bash
claude --version    # should show a version number
git --version       # should show a version number  
node --version      # should show v18 or higher
```

If any are missing, install them before continuing.

---

### 1. Find your Claude Code skills folder

Skills live in a specific folder Claude Code automatically reads from. Where it is depends on your OS:

| OS | Skills folder path |
|------|-------------------|
| **macOS / Linux** | `~/.claude/skills/` |
| **Windows** | `C:\Users\<your-username>\.claude\skills\` (in Git Bash: `~/.claude/skills/`) |

Don't worry about creating it manually — the next step does that automatically.

---

### 2. Clone vibe-builder into the skills folder

Open your terminal and run **one** of these depending on your OS:

**macOS / Linux / Windows (Git Bash):**
```bash
git clone https://github.com/helldock0/vibe-builder.git ~/.claude/skills/vibe-builder
```

**Windows (PowerShell):**
```powershell
git clone https://github.com/helldock0/vibe-builder.git "$env:USERPROFILE\.claude\skills\vibe-builder"
```

This downloads the skill (including the bundled UI/UX engine) into the right place. Takes about 30 seconds.

---

### 3. Verify it installed correctly

```bash
ls ~/.claude/skills/vibe-builder/
```

You should see: `bin/`, `bundled/`, `CREDITS.md`, `LICENSE`, `README.md`, `SKILL.md`

If you see those, **the skill is installed.** That's it.

---

### 4. Test it

Open Claude Code in any folder (preferably a fresh empty one to avoid mixing with existing projects):

```bash
mkdir my-first-build
cd my-first-build
claude
```

Then type something like:

> *i wanna build a simple website to keep track of my reading list*

vibe-builder should auto-trigger and start its workflow. If it doesn't, restart Claude Code (close and reopen) — sometimes new skills need a session restart to register.

---

### 5. (Optional) one-line companion installs

vibe-builder is way better with these. Both are one command.

#### 🧠 claude-mem — persistent memory across sessions

```bash
bash ~/.claude/skills/vibe-builder/bin/install-claude-mem.sh
```

Without this, Claude Code forgets everything between sessions. With it, you pick up exactly where you left off.

#### 📊 statusline — see usage limits in your terminal

```bash
bash ~/.claude/skills/vibe-builder/bin/install-statusline.sh
```

Adds a status bar at the bottom of Claude Code showing context %, 5-hour usage %, weekly usage %, and cost — color-coded (green / yellow / red).

Preview:
````
my-project main │ Opus 4.7 │ ctx ▓░░░ 24% │ 5h ▓▓░░ 35% │ wk 17% │ $0.42
````

The installer checks prereqs (jq, curl), backs up your existing `~/.claude/settings.json`, safely merges in the new config, and smoke-tests the script before you restart. If anything fails, your settings.json is untouched.

To remove later: `bash ~/.claude/skills/vibe-builder/bin/uninstall-statusline.sh`

---

### 🆘 troubleshooting

| Problem | Fix |
|---------|-----|
| Skill doesn't trigger when I describe my idea | Restart Claude Code completely (close and reopen). Skills register at startup. |
| `git: command not found` | Install Git from https://git-scm.com |
| `~` doesn't work in my terminal | Replace `~` with your full home path: e.g. `/Users/yourname/` (Mac) or `C:\Users\yourname\` (Windows) |
| `bundled/ui-ux-pro-max/SKILL.md not found` | The clone didn't include all files. Delete the folder and re-clone. |
| Statusline shows `?` for everything | jq not installed (the installer would have caught this), or no API call has happened yet in the session — type one message and it'll populate. |
| Statusline installer says "jq not installed" | Install jq: Windows `winget install jqlang.jq`, macOS `brew install jq`, Linux `sudo apt install jq`. Then re-run the installer. |

Still stuck? Open an [issue on GitHub](https://github.com/helldock0/vibe-builder/issues). I read every one.

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
├── README.md             # this file
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

Built by [James](https://github.com/helldock0) ([@Helldock](https://github.com/helldock0)) — based in Tamil Nadu, India 🇮🇳

⭐ if this saved you from "what stack should I use?" paralysis, throw a star

</div>
