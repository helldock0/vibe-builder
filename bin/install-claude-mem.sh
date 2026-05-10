#!/usr/bin/env bash
# vibe-builder — claude-mem one-line installer wrapper
# Just calls thedotmack/claude-mem's official installer; this exists for symmetry with the statusline installer.

set -euo pipefail

GRN='\033[32m'; YLW='\033[33m'; RED='\033[91m'; DIM='\033[2m'; RST='\033[0m'
ok()   { echo -e "${GRN}✓${RST} $*"; }
warn() { echo -e "${YLW}!${RST} $*"; }
err()  { echo -e "${RED}✗${RST} $*"; }

echo ""
echo "vibe-builder — claude-mem installer wrapper"
echo "-------------------------------------------"
echo ""

if ! command -v node >/dev/null 2>&1; then
  err "Node.js not installed — claude-mem requires Node 18+"
  err "install from https://nodejs.org (LTS), then re-run this"
  exit 1
fi

NODE_MAJOR=$(node -v | sed 's/v//' | cut -d. -f1)
if [ "$NODE_MAJOR" -lt 18 ]; then
  err "Node.js v18+ required — you have v$(node -v)"
  err "upgrade from https://nodejs.org, then re-run this"
  exit 1
fi
ok "Node.js $(node -v)"

if ! command -v npx >/dev/null 2>&1; then
  err "npx not found — usually ships with Node.js. try reinstalling Node from nodejs.org"
  exit 1
fi
ok "npx available"

echo ""
warn "handing off to claude-mem's official installer (thedotmack/claude-mem)"
echo "this is a different tool — it'll prompt you for some setup choices."
echo "for most people, the defaults are fine."
echo ""

# Just call their installer
npx claude-mem install

echo ""
ok "claude-mem install finished"
echo "more info: https://github.com/thedotmack/claude-mem"
echo ""
