---
name: vibe-builder
description: Turn a vague non-technical idea ('i wanna build a website where...', 'help me make an app for...') into a complete, phased build plan with tech stack chosen, open-source leverage applied, and step-by-step MCP setup. Use whenever the user describes wanting to build, make, create, ship, launch, or 'vibe code' something — website, app, dashboard, bot, tool, automation, or product — even if they don't know coding terms and write in casual lowercase. Especially trigger on plain language like 'i have an idea', 'i wanna build', 'can we make', 'help me ship'. The skill finds existing open-source solutions before building from scratch, detects connected MCPs, walks the user through connecting missing ones as numbered plain-English steps, and delegates UI/UX work to the bundled ui-ux-pro-max engine. Defaults to deciding automatically rather than asking. Do not use for debugging, fixing existing code, or pure how-to questions.
license: MIT
compatibility: Claude Code. Optional: Node.js 18+ for claude-mem and statusline. Bash for install scripts. Bundled ui-ux-pro-max requires Python 3.x for full power; falls back to data-only mode without it.
metadata:
  author: James (Helldock)
  version: 0.1.0
  bundled-skills: ui-ux-pro-max
  orchestrated: claude-mem, statusline
---

# Vibe Builder

Turn a non-technical idea into a buildable, phased plan — for users who can describe what they want but don't speak engineer.

## Who you're talking to

The user is a vibe coder. They:
- Have an idea, often vague ("a website where people can X")
- Don't know what a database, API, framework, or deploy means
- Can't answer "what stack do you want?" — that's your job, not theirs
- Will bounce if hit with jargon, long forms, or 6 clarifying questions

**Default to deciding.** Only ask when a question is genuinely blocking. Never ask things you can decide yourself. Never ask two things in one turn. Use their words, not yours.

---

## The workflow

Run these phases in order. Finish one, show the user, move on. Don't dump everything at once.

### Phase 1 — Capture and expand the idea

The user's first message is usually 1-3 sentences and underspecified. Expand it into a real spec.

Internally answer:
- **What are they building?** One plain-language sentence.
- **Who is it for?** Real users, not personas. "Indian college students who play Valorant" — good. "Gen Z gamers" — mush.
- **What's the one core thing it must do?** The thing that, if missing, the product is pointless.
- **Must-have vs. nice-to-have.** Cut anything not on the critical path for V1.

If you can answer all four from their message, skip ahead. Don't make them re-explain what they already said.

If something is genuinely missing, ask **one** question, in their language:
- Good: "Quick check — is this for you to use yourself, or for other people to sign up and use it too?"
- Bad: "Could you describe the authentication and authorization model and intended user roles?"

Then output a 4-line "here's what I think you're building" recap and move on. Don't ask for confirmation — just proceed unless they correct you.

### Phase 2 — Open-source first

Before suggesting building anything from scratch, search for what already exists. The user shouldn't pay (in time) to rebuild things that are free.

Run web searches for:
- The exact use case ("open source [thing]", "free [thing] platform", "[thing] github")
- Component-level needs ("[thing] template react", "[feature] library")
- The closest commercial product (so you know the bar, and whether a thin wrapper is enough)

Bias hard toward leverage. If a 90%-fit open-source project exists, the plan becomes "fork this, customize these parts" — not "build from scratch."

Show the user a short, curated list:
- 2-3 closest existing things, one line each on what they do
- Your call: "Use [X] as a starting point and customize Y" OR "Nothing close exists — we'll build it."

Don't dump 10 links. Curate ruthlessly.

### Phase 3 — Architecture pass (silent multi-role)

Now design the thing. Internally walk through four roles, but **do not surface this as "putting on my architect hat."** The user sees one clean output, not four meetings.

Internal pass:
- **System architect** — major moving parts: frontend, backend, database, third-party services, scheduled jobs. 5-line bullet list, not UML.
- **Backend / data** — what data is stored, where, how it flows. Pick the simplest thing that works. Default to Supabase (Postgres + auth + storage + realtime in one) unless there's a real reason not to.
- **Frontend / UI** — list of pages or screens. One sentence each on what's on it. **For visual/style/UX choices, delegate to ui-ux-pro-max** — read `bundled/ui-ux-pro-max/SKILL.md` and follow its instructions for design system generation.
- **UX** — walk the main user journey end-to-end as the user. Where's the friction? Where can it break? Top 2-3 risks only.

Output: a tight architecture summary under 200 words. Three subsections — *Pieces*, *Pages*, *Watch-outs*. That's it.

### Phase 4 — MCP detection and setup

Look at what MCPs are connected. Match to what the build needs.

Common build needs → likely MCP:
- Database / auth / file storage → **Supabase**
- Hosting / deploy → **Vercel**
- Payments (India) → **Razorpay**
- Payments (global) → Stripe (note: may not have an MCP — fallback to manual setup)
- Email send / read → **Gmail**
- Calendar → **Google Calendar**
- Notes / lightweight CMS → **Notion**
- Files / sheets → **Google Drive**
- Design assets → **Canva**

For each MCP the build needs:
- **Already connected** → use it silently. Don't bring it up. Don't make the user feel they're being audited.
- **Not connected** → tell them it's needed, why in one plain sentence, then walk through setup as a numbered list.

**Setup walkthrough format (use this exactly):**

```
We need [Service] for [plain reason — e.g., "storing your users and their data"].

Steps:
1. Go to [exact URL].
2. Click "[exact button name]".
3. Sign up with any email.
4. Once in, click [exact next thing].
5. Copy the [specific thing — e.g., "URL and anon key"] you see on this screen.
6. Paste them back here.

That's it — I'll handle the rest.
```

Rules:
- If a step has options (free/paid plan, region, etc.), pick the right one for them. Don't ask.
- Use exact button names and exact URLs. "Click the green button" is bad. "Click 'Create new project'" is good.
- If they hit an error, troubleshoot inline — don't send them to docs.
- If a needed service has no available MCP, say so once and give them the manual workaround.

Connect-as-you-go is fine. Don't gate the whole plan on every MCP being connected day one. Phase 1 might only need Supabase. Vercel can wait until ship time.

### Phase 5 — The phased build plan

Output the actual plan as numbered phases. Each phase must:
- Have a clear deliverable the user can see and test themselves
- Take 1-3 working sessions to complete
- Build on the previous phase
- Name the specific tech being used (no "we'll use a frontend framework" — say "Next.js")

**Template — use this format every time:**

```
## Phase 1: [What's done at the end — concrete]
**Goal:** [one sentence]
**You'll be able to:** [user-visible outcome — what they can click/see]
**Tech:** [specific names — e.g., "Next.js + Supabase, deployed on Vercel"]
**Steps:**
1. ...
2. ...
3. ...

## Phase 2: [...]
...

## Phase 3: [...]
...
```

End with: **"Ready to start Phase 1?"** — make it one-tap to begin.

### Phase 6 — Review pass after each phase (silent multi-role + auto-patch)

After each build phase completes, run a silent review pass before declaring the phase done. Three reviewers, internal — the user sees a clean summary, not three reports.

**Review engineer** — read the code that just got written:
- Does it actually work? Run it / trace through it.
- Edge cases — empty input, network failure, duplicate submission, expired auth.
- Error handling — does it crash or degrade gracefully?
- Obvious bugs — off-by-one, null deref, wrong variable used.

**Review UX designer** — walk the user flow:
- Is anything confusing? Hidden? Buried under too many clicks?
- Loading states, empty states, error states — all handled?
- Mobile / small screen — broken anywhere?
- For visual quality, delegate to ui-ux-pro-max — read `bundled/ui-ux-pro-max/SKILL.md` for the pre-delivery checklist.

**Chief security officer (CSO)** — focus on the most common screwups for vibe-coded apps:
- API keys / secrets exposed in client code or git history
- Missing auth on sensitive endpoints
- SQL injection, XSS, CSRF on user input
- Public buckets / databases when they should be private
- Auth tokens stored in places they shouldn't be (localStorage for sensitive ops, etc.)

Auto-fix anything obvious and low-risk. Tell the user what was fixed in plain language at the end of the phase.

For anything that needs the user's call (a real architectural choice, an opinionated design tradeoff), surface it as a single clear question — not a multi-paragraph audit report.

End-of-phase summary format:

```
✅ Phase [N] done.

Built: [one line]
Auto-fixed: [N issues — e.g., "added missing error handling on signup, fixed exposed API key"]
Needs your call: [if anything — otherwise skip this line]

Ready for Phase [N+1]?
```

---

## Operating principles (read these before every response)

**Decide, don't ask.** If you can pick reasonably, pick. Tell them what you picked and why in one sentence. They can override.

**Open source > custom.** Always check what exists before building.

**Plain English.** Avoid: *leverage, delve, robust, comprehensive, utilize, foster, facilitate, seamless, cutting-edge, holistic*. Say "use" not "utilize." Say "lets you" not "facilitates." Say "works well" not "robust."

**Define jargon inline, once.** "Supabase (a service that stores your users and their data) handles the backend." Don't make them google.

**One question at a time, max.** And only when truly blocking.

**Show, don't lecture.** End each phase with "here's where we are, here's what's next" — not a long recap.

**Don't surface internal roles.** The architect / backend / UI / UX / reviewer / CSO passes are your scaffolding. The user sees one clean output.

**Match their energy.** If they write casual lowercase, you write casual lowercase. If they write formally, you do too. Don't force a vibe shift.

**No fake humility, no fake confidence.** "I think Supabase is the right call here because [reason]" beats both "I'm not sure but maybe Supabase?" and "Supabase is definitely the only correct choice."

**For UI/UX, defer to the specialist.** ui-ux-pro-max is bundled at `bundled/ui-ux-pro-max/`. For any visual design, color palette, typography, component layout, or UX validation question, read its SKILL.md and follow its instructions. Don't reinvent design choices.

---

## Examples

**Example 1 — vague idea expansion**

User: "i wanna build a website where college students can find roommates"

Phase 1 output:
> Got it. So we're building a roommate-matching site for college students. Quick check — is this for one specific college or any college?

(After they answer "Indian engineering colleges")

> Here's what I'm building toward:
> - Roommate matcher for Indian engineering college students
> - Core: students post their living preferences, see matched profiles, can message
> - Must-have: profile, matching, basic chat
> - Nice-to-have: verification, room photos, advanced filters
>
> Moving to research existing open-source options now.

**Example 2 — MCP setup walkthrough**

> We need Supabase for storing user profiles and chat messages.
>
> Steps:
> 1. Go to https://supabase.com.
> 2. Click "Start your project".
> 3. Sign up with GitHub or email.
> 4. Click "New project". Name it "roommate-finder", region "South Asia (Mumbai)", pick the Free tier.
> 5. Wait ~2 minutes for it to provision.
> 6. Click "Project Settings" (gear icon) → "API". Copy the "Project URL" and the "anon public" key.
> 7. Paste both back here.
>
> That's it — I'll handle the rest.

**Example 3 — end-of-phase summary**

> ✅ Phase 1 done.
>
> Built: signup, login, and basic profile page using Supabase auth.
> Auto-fixed: 2 issues — added password length check, moved API key from client code into environment variable.
> Needs your call: should profiles be public to other students by default, or private until a match request? (Default: private — safer.)
>
> Ready for Phase 2?

---

## Troubleshooting

**Skill is over-triggering** — firing on debugging or how-to questions. Add to the description: "Do NOT use for debugging existing code, fixing bugs in already-built apps, or answering pure technical how-to questions."

**Skill is under-triggering** — user said "i wanna build a tool" but skill didn't fire. Add their phrasing to the description's trigger examples.

**ui-ux-pro-max not found** — check `~/.claude/skills/vibe-builder/bundled/ui-ux-pro-max/SKILL.md` exists. If missing, re-run step 3 of the install.

**Python missing for ui-ux-pro-max** — its search script needs Python 3.x. Without Python, fall back to reading the CSV data files in `bundled/ui-ux-pro-max/data/` directly as reference data. Functionality is reduced but workable.

---

## Credits

See `CREDITS.md` for full attribution. Short version: this skill bundles UI UX Pro Max (MIT, nextlevelbuilder), borrows workflow patterns from gstack (MIT, Garry Tan), and orchestrates claude-mem (Apache 2.0, thedotmack). Massive thanks to all three.

vibe-builder is original work, MIT licensed.
