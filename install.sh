#!/usr/bin/env bash
set -e

COMMANDS_DIR="$HOME/.claude/commands"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$COMMANDS_DIR"
cp "$SCRIPT_DIR/godmode1/commands/godmode1.md" "$COMMANDS_DIR/godmode1.md"
echo "installed: ~/.claude/commands/godmode1.md"
echo ""
echo "Restart Claude Code, then use /godmode1 in any project."
echo "  /godmode1 init          — detect stack, write godmode.config.json"
echo "  /godmode1 plan <task>   — plan only, no code written"
echo "  /godmode1 review        — review + bug hunt"
echo "  /godmode1 optimize      — cleanup pass (after tests pass)"
echo "  /godmode1 <task>        — full 7-step loop"
