#!/usr/bin/env bash
# Drop this in ~/.claude/hooks/session-start.sh
# It re-syncs godmode1 commands at the start of every session (web or local).

REPO="https://github.com/dinokegalj9-crypto/plugin"
CACHE="$HOME/.claude/.godmode1-cache"
COMMANDS_DIR="$HOME/.claude/commands"

mkdir -p "$COMMANDS_DIR"

# Re-clone only if cache is missing or older than 24 h
if [ ! -d "$CACHE" ] || [ -n "$(find "$CACHE" -maxdepth 0 -mmin +1440 2>/dev/null)" ]; then
  rm -rf "$CACHE"
  git clone --depth 1 --quiet "$REPO" "$CACHE" 2>/dev/null || exit 0
fi

for f in "$CACHE/godmode1/commands/"*.md; do
  cp "$f" "$COMMANDS_DIR/$(basename "$f")"
done
