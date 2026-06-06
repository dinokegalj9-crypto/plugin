# godmode1

A project-agnostic Claude Code plugin that enforces one disciplined engineering loop:

> understand -> plan -> dependencies -> execute -> review -> bug-hunt -> optimize

It is "general" by design: behaviour lives in `godmode.config.json`, so the same plugin
adapts to any language or stack. No logic is hardcoded to a framework.

## What's inside
| Piece | Path | Purpose |
|------|------|---------|
| Manifest | `.claude-plugin/plugin.json` | Plugin metadata + wiring |
| Config | `godmode.config.json` | Per-project customization (the part you edit) |
| `/godmode-init` | `commands/godmode-init.md` | Zero-setup: auto-detect stack, write config |
| `/godmode` | `commands/godmode.md` | Full gated 7-step run on a task |
| `/plan` | `commands/plan.md` | Planning only, no code written |
| `/review` | `commands/review.md` | Self-review + bug hunt on changes |
| `/optimize` | `commands/optimize.md` | Speed/cleanup pass (only after tests pass) |
| `code-reviewer` | `agents/code-reviewer.md` | Skeptical senior-reviewer subagent |
| `bug-hunter` | `agents/bug-hunter.md` | Adversarial edge-case finder subagent |
| Skill | `skills/godmode-workflow/SKILL.md` | The loop itself, auto-loaded when relevant |
| Hooks | `hooks/hooks.json` | Optional guardrail against destructive commands |

## Install (local dev)
1. Add a marketplace pointing at this folder, then install the plugin:
   ```
   /plugin marketplace add ./path/to/godmode1-marketplace
   /plugin install godmode1
   ```
   (Or use whatever current install flow `/plugin` shows — verify against the Claude Code
   plugin docs, since the command surface evolves.)
2. In any repo, run `/godmode-init` to auto-detect the stack and write the config,
   then tweak. (Manual path: copy `godmode.config.json` into the project root and edit the `project`, `stack`,
   `commands`, and `guardrails` sections.

> Note: Claude Code derives each command name from its filename and may namespace it by
> plugin, so commands can appear as `/godmode-init` or `/godmode1:godmode-init`. If `/godmode-init`
> isn't found, type `/` and check the list for the exact name.

## Customize per project
Open `godmode.config.json` and set:
- `project.summary` — what it is, who it's for
- `commands.*` — real install/build/test/lint commands (or leave `"auto"`)
- `workflow.enabled_steps` — drop steps you don't want
- `workflow.strictness` — `low` / `medium` / `high`
- `guardrails.never_touch` + `protected_branches`

That one file re-skins the whole workflow. Nothing else needs editing.

## Notes / verify-before-trust
The plugin manifest fields, hook event names (`PreToolUse`), and `/plugin` install commands
follow the documented Claude Code plugin model, but that surface changes — confirm the exact
schema against the current Claude Code plugin docs before relying on it in production.
