#!/usr/bin/env bash
# vibe-builder statusline
# Shows: dir, branch, model, context %, 5-hour %, weekly all + opus + sonnet, cost
# Approach borrowed (with credit) from ohugonnot/claude-code-statusline (MIT-style approach)
# Calls Anthropic OAuth usage API for per-model breakdown.

set -uo pipefail

# Read JSON from stdin
INPUT=$(cat)

# Helpers
get_field() { echo "$INPUT" | jq -r "$1 // empty" 2>/dev/null; }

# Color codes
GRN='\033[32m'; YLW='\033[33m'; RED='\033[91m'; DIM='\033[2m'; RST='\033[0m'

# Color picker — pure bash integer arithmetic (no bc dependency)
color_for() {
  local pct=$1
  if [ -z "$pct" ] || [ "$pct" = "null" ]; then echo "$DIM"; return; fi
  local int_pct=${pct%.*}
  if ! [[ "$int_pct" =~ ^[0-9]+$ ]]; then echo "$DIM"; return; fi
  if [ "$int_pct" -lt 45 ]; then echo "$GRN"
  elif [ "$int_pct" -lt 70 ]; then echo "$YLW"
  else echo "$RED"; fi
}

# Mini progress bar (4 chars)
bar() {
  local pct=${1:-0}
  pct=${pct%.*}  # strip decimals
  local filled=$(( pct * 4 / 100 ))
  [ $filled -gt 4 ] && filled=4
  [ $filled -lt 0 ] && filled=0
  local empty=$((4 - filled))
  [ $filled -gt 0 ] && printf '%0.s▓' $(seq 1 $filled 2>/dev/null)
  [ $empty -gt 0 ] && printf '%0.s░' $(seq 1 $empty 2>/dev/null)
}

# Extract from stdin
DIR=$(get_field '.workspace.current_dir')
DIR="${DIR##*/}"     # strip up to last forward slash
DIR="${DIR##*\\}"    # strip up to last backslash (Windows paths)
[ -z "$DIR" ] && DIR="?"
MODEL=$(get_field '.model.display_name')
[ -z "$MODEL" ] && MODEL="?"
CTX_PCT=$(get_field '.context_window.used_percentage')
COST=$(get_field '.cost.total_cost_usd')

# Git branch (if in a git repo)
BRANCH=""
if [ -n "$(get_field '.workspace.current_dir')" ]; then
  BRANCH=$(cd "$(get_field '.workspace.current_dir')" 2>/dev/null && git branch --show-current 2>/dev/null)
fi

# Native rate_limits from stdin (5h + 7d combined, no per-model)
NATIVE_5H=$(get_field '.rate_limits.five_hour.used_percentage')
NATIVE_7D=$(get_field '.rate_limits.seven_day.used_percentage')

# Try to enrich with per-model from OAuth API (cached 60s)
CACHE_FILE="$HOME/.claude/usage-cache.json"
CACHE_AGE=999
[ -f "$CACHE_FILE" ] && CACHE_AGE=$(( $(date +%s) - $(stat -c %Y "$CACHE_FILE" 2>/dev/null || stat -f %m "$CACHE_FILE" 2>/dev/null || echo 0) ))

OPUS_WK=""; SNT_WK=""
if [ $CACHE_AGE -gt 60 ]; then
  CREDS_FILE="$HOME/.claude/.credentials.json"
  if [ -f "$CREDS_FILE" ]; then
    TOKEN=$(jq -r '.claudeAiOauth.accessToken // empty' "$CREDS_FILE" 2>/dev/null)
    if [ -n "$TOKEN" ]; then
      curl -s --max-time 3 "https://api.anthropic.com/api/oauth/usage" \
        -H "Authorization: Bearer $TOKEN" \
        -H "anthropic-beta: oauth-2025-04-20" \
        -H "Content-Type: application/json" > "$CACHE_FILE.tmp" 2>/dev/null \
        && mv "$CACHE_FILE.tmp" "$CACHE_FILE"
    fi
  fi
fi

if [ -f "$CACHE_FILE" ]; then
  OPUS_WK=$(jq -r '.seven_day.opus.utilization // empty' "$CACHE_FILE" 2>/dev/null)
  SNT_WK=$(jq -r '.seven_day.sonnet.utilization // empty' "$CACHE_FILE" 2>/dev/null)
fi

# Build output
OUT="${DIR}"
[ -n "$BRANCH" ] && OUT="${OUT} ${BRANCH}"
OUT="${OUT} │ ${MODEL}"

if [ -n "$CTX_PCT" ] && [ "$CTX_PCT" != "null" ]; then
  CTX_C=$(color_for "$CTX_PCT")
  OUT="${OUT} │ ctx ${CTX_C}$(bar $CTX_PCT) ${CTX_PCT%.*}%${RST}"
fi

if [ -n "$NATIVE_5H" ] && [ "$NATIVE_5H" != "null" ]; then
  H5_C=$(color_for "$NATIVE_5H")
  OUT="${OUT} │ 5h ${H5_C}$(bar $NATIVE_5H) ${NATIVE_5H%.*}%${RST}"
fi

if [ -n "$NATIVE_7D" ] && [ "$NATIVE_7D" != "null" ]; then
  WK_C=$(color_for "$NATIVE_7D")
  OUT="${OUT} │ wk ${WK_C}${NATIVE_7D%.*}%${RST}"
  [ -n "$OPUS_WK" ] && [ "$OPUS_WK" != "null" ] && OUT="${OUT} • opus ${OPUS_WK%.*}%"
  [ -n "$SNT_WK" ] && [ "$SNT_WK" != "null" ] && OUT="${OUT} • snt ${SNT_WK%.*}%"
fi

if [ -n "$COST" ] && [ "$COST" != "null" ]; then
  OUT="${OUT} │ \$$(printf '%.2f' $COST 2>/dev/null || echo $COST)"
fi

echo -e "$OUT"
