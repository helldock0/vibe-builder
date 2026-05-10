#!/usr/bin/env bash
# vibe-builder — one-command statusline installer
# Safely merges statusLine config into ~/.claude/settings.json with backup + verification.

set -euo pipefail

CLAUDE_DIR="$HOME/.claude"
SETTINGS="$CLAUDE_DIR/settings.json"
SCRIPT_PATH="$HOME/.claude/skills/vibe-builder/bin/statusline.sh"

GRN='\033[32m'; YLW='\033[33m'; RED='\033[91m'; DIM='\033[2m'; RST='\033[0m'

say()  { echo -e "${DIM}→${RST} $*"; }
ok()   { echo -e "${GRN}✓${RST} $*"; }
warn() { echo -e "${YLW}!${RST} $*"; }
err()  { echo -e "${RED}✗${RST} $*"; }

echo ""
echo "vibe-builder statusline installer"
echo "---------------------------------"
echo ""

# 1. Prereq: statusline.sh exists
say "checking statusline.sh exists..."
if [ ! -f "$SCRIPT_PATH" ]; then
  err "statusline.sh not found at $SCRIPT_PATH"
  err "is vibe-builder installed at ~/.claude/skills/vibe-builder/?"
  exit 1
fi
ok "statusline.sh found"

# 2. Prereq: jq
say "checking jq..."
if ! command -v jq >/dev/null 2>&1; then
  warn "jq not installed"
  echo ""
  echo "jq is needed to safely edit your settings.json without breaking it."
  echo "How to install:"
  echo "  • Windows:  winget install jqlang.jq"
  echo "  • macOS:    brew install jq"
  echo "  • Linux:    sudo apt install jq  (or your distro's equivalent)"
  echo ""
  echo "Install jq, then re-run this script."
  exit 1
fi
ok "jq installed ($(jq --version))"

# 3. Prereq: curl
say "checking curl..."
if ! command -v curl >/dev/null 2>&1; then
  err "curl not installed — needed for fetching per-model usage data"
  err "install curl, then re-run this script"
  exit 1
fi
ok "curl installed"

# 4. Make sure ~/.claude/ exists
mkdir -p "$CLAUDE_DIR"

# 5. Create or back up settings.json
if [ ! -f "$SETTINGS" ]; then
  say "settings.json doesn't exist — creating fresh"
  echo '{}' > "$SETTINGS"
  ok "created $SETTINGS"
else
  TS=$(date +%Y%m%d-%H%M%S)
  BACKUP="$SETTINGS.bak.$TS"
  cp "$SETTINGS" "$BACKUP"
  ok "backed up existing settings.json → $BACKUP"
fi

# 6. Validate existing settings.json is valid JSON
if ! jq empty "$SETTINGS" 2>/dev/null; then
  err "$SETTINGS is not valid JSON — fix or delete it before installing"
  exit 1
fi

# 7. Check if statusLine already configured
if jq -e '.statusLine' "$SETTINGS" >/dev/null 2>&1; then
  EXISTING_CMD=$(jq -r '.statusLine.command // ""' "$SETTINGS")
  if [[ "$EXISTING_CMD" == *"vibe-builder/bin/statusline.sh"* ]]; then
    ok "vibe-builder statusline already configured — nothing to do"
    exit 0
  fi
  warn "another statusLine is already set: $EXISTING_CMD"
  warn "replacing it with vibe-builder's. (your old one is in the backup above.)"
fi

# 8. Merge in the statusLine block (preserves all other keys)
say "writing statusLine config..."
TMP="$SETTINGS.tmp"
jq --arg cmd "bash ~/.claude/skills/vibe-builder/bin/statusline.sh" \
   '.statusLine = {type: "command", command: $cmd, padding: 0}' \
   "$SETTINGS" > "$TMP"

# 9. Validate the result before swapping in
if ! jq empty "$TMP" 2>/dev/null; then
  err "merge produced invalid JSON — aborting, settings.json untouched"
  rm -f "$TMP"
  exit 1
fi
mv "$TMP" "$SETTINGS"
ok "statusLine config written"

# 10. Smoke test the statusline script
say "smoke-testing statusline.sh..."
TEST_INPUT='{"model":{"display_name":"Opus 4.7"},"workspace":{"current_dir":"/tmp/test"},"context_window":{"used_percentage":24},"rate_limits":{"five_hour":{"used_percentage":35},"seven_day":{"used_percentage":17}},"cost":{"total_cost_usd":0.42}}'
TEST_OUTPUT=$(echo "$TEST_INPUT" | bash "$SCRIPT_PATH" 2>&1 || echo "FAILED")

if [[ "$TEST_OUTPUT" == "FAILED" ]] || [[ -z "$TEST_OUTPUT" ]]; then
  err "statusline script crashed during smoke test — output:"
  echo "$TEST_OUTPUT"
  exit 1
fi
ok "smoke test passed"

# Done
echo ""
echo "---------------------------------"
ok "statusline installed"
echo ""
echo "preview (with sample data):"
echo "  $TEST_OUTPUT"
echo ""
echo "next steps:"
echo "  1. restart Claude Code (close and reopen)"
echo "  2. you'll see the statusline at the bottom of your terminal"
echo ""
echo "to uninstall later: bash ~/.claude/skills/vibe-builder/bin/uninstall-statusline.sh"
echo ""
