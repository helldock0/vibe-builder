# vibe-builder

Turn a vague non-technical idea into a complete, phased build plan — for people who can describe what they want but don't speak engineer.

````
you: "i wanna build a website where indie game devs can post their games"
vibe-builder: [expands the idea] [searches for existing open-source options]
              [picks a stack] [walks you through any setup needed]
              [outputs a phased plan with specific tech named]
              [auto-reviews each phase for bugs, UX gaps, security holes]
````

Built for vibe coders — people building real products without a coding background.

## What it does

- **Captures and expands** your half-baked idea into a real spec
- **Searches first** for existing open-source projects you can fork instead of building from scratch
- **Picks the stack** for you (no "what database do you want?" questions)
- **Walks you through** any service setup with exact button names and URLs — no jargon
- **Outputs phases** with concrete deliverables you can test
- **Auto-reviews** each phase silently — fixes obvious bugs, flags real risks
- **Defers UI/UX** to the bundled [UI UX Pro Max](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) engine for design intelligence

## Install

This is a [Claude Code skill](https://docs.claude.com/en/docs/claude-code/skills). It runs inside Claude Code on your machine.

```bash
git clone https://github.com/helldock0/vibe-builder.git ~/.claude/skills/vibe-builder
```

That's it. Open Claude Code and describe what you want to build — vibe-builder activates automatically.

### Optional companions

vibe-builder works best when paired with:

- **claude-mem** — persistent memory across sessions: `npx claude-mem install`
- **statusline** — usage limit display in your terminal. The `bin/statusline.sh` script ships with this skill; see SKILL.md for setup.

## Credits

This skill stands on the shoulders of three excellent open-source projects:

- **[UI UX Pro Max](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill)** by nextlevelbuilder (MIT) — bundled in full for design intelligence
- **[gstack](https://github.com/garrytan/gstack)** by Garry Tan / Y Combinator (MIT) — multi-role workflow patterns borrowed
- **[claude-mem](https://github.com/thedotmack/claude-mem)** by thedotmack (Apache 2.0) — recommended companion for persistent memory

Massive thanks to all three. Full attribution in [CREDITS.md](./CREDITS.md).

## License

[MIT](./LICENSE) — free forever. Fork it, improve it, make it yours.

Built by [James](https://github.com/helldock0) (Helldock).
