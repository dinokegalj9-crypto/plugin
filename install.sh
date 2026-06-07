#!/usr/bin/env bash
set -e

COMMANDS_DIR="$HOME/.claude/commands"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$SCRIPT_DIR/godmode1"

mkdir -p "$COMMANDS_DIR"

for f in "$PLUGIN_DIR/commands/"*.md; do
  name="$(basename "$f")"
  cp "$f" "$COMMANDS_DIR/$name"
  echo "installed: ~/.claude/commands/$name"
done

echo ""
echo "godmode1 installed. Restart Claude Code, then try /godmode-init in any project."
