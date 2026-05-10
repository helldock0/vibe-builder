# Credits & Attribution

vibe-builder stands on the shoulders of these excellent open-source projects. Massive thanks to their creators.

## Bundled

### UI UX Pro Max — design intelligence engine
- **Repo:** https://github.com/nextlevelbuilder/ui-ux-pro-max-skill
- **Author:** nextlevelbuilder
- **License:** MIT
- **Used for:** the entire UI/UX phase. Bundled in full inside `bundled/ui-ux-pro-max/`. Provides 67 UI styles, 161 color palettes, 57 font pairings, 99 UX guidelines, and 161 industry-specific reasoning rules.

## Patterns borrowed (with credit)

### gstack — multi-role workflow patterns
- **Repo:** https://github.com/garrytan/gstack
- **Author:** Garry Tan (President & CEO, Y Combinator)
- **License:** MIT
- **Used for:** the silent multi-role workflow pattern (architect / reviewer / CSO / etc.). Prompt structures adapted from `/office-hours`, `/plan-eng-review`, `/review`, and `/cso`.

## Orchestrated (installed alongside)

### claude-mem — persistent memory across sessions
- **Repo:** https://github.com/thedotmack/claude-mem
- **Author:** Alex Newman / thedotmack
- **License:** Apache 2.0
- **Used for:** persistent memory across Claude Code sessions. Installed via `npx claude-mem install` during vibe-builder setup.

### claude-code-statusline — per-model usage approach
- **Repo:** https://github.com/ohugonnot/claude-code-statusline
- **Author:** ohugonnot
- **Used for:** the approach of calling Anthropic's OAuth usage API for per-model breakdown (Opus weekly vs Sonnet weekly). Our `bin/statusline.sh` follows this approach.

---

vibe-builder is original work by James (Helldock), released under the MIT License.
