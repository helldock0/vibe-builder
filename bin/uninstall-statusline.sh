#!/usr/bin/env bash
# vibe-builder — statusline uninstaller
# Removes the statusLine block from settings.json (preserves all other keys + backs up first).

set -euo pipefail

SETTINGS="$HOME/.claude/settings.json"

GRN='\033[32m'; YLW='\033[33m'; RED='\033[91m'; DIM='\033[2m'; RST='\033[0m'
ok()   { echo -e "${GRN}✓${RST} $*"; }
warn() { echo -e "${YLW}!${RST} $*"; }
err()  { echo -e "${RED}✗${RST} $*"; }

echo ""
echo "vibe-builder statusline uninstaller"
echo "-----------------------------------"
echo ""

if [ ! -f "$SETTINGS" ]; then
  warn "no settings.json found — nothing to uninstall"
  exit 0
fi

if ! command -v jq >/dev/null 2>&1; then
  err "jq required for safe edits — install it first"
  exit 1
fi

if ! jq empty "$SETTINGS" 2>/dev/null; then
  err "settings.json is not valid JSON — fix it before uninstalling"
  exit 1
fi

# Check if statusLine is ours
EXISTING_CMD=$(jq -r '.statusLine.command // ""' "$SETTINGS")
if [[ "$EXISTING_CMD" != *"vibe-builder/bin/statusline.sh"* ]]; then
  warn "current statusLine isn't vibe-builder's — refusing to remove it"
  warn "current: $EXISTING_CMD"
  exit 0
fi

# Backup
TS=$(date +%Y%m%d-%H%M%S)
BACKUP="$SETTINGS.bak.$TS"
cp "$SETTINGS" "$BACKUP"
ok "backed up settings.json → $BACKUP"

# Remove statusLine key
TMP="$SETTINGS.tmp"
jq 'del(.statusLine)' "$SETTINGS" > "$TMP"
if ! jq empty "$TMP" 2>/dev/null; then
  err "edit produced invalid JSON — aborting, settings.json untouched"
  rm -f "$TMP"
  exit 1
fi
mv "$TMP" "$SETTINGS"
ok "statusLine removed from settings.json"

echo ""
echo "restart Claude Code to clear the statusline display."
echo "(your old config is preserved in $BACKUP if you want it back.)"
echo ""
