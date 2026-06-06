---
name: godmode-workflow
description: The disciplined 7-step engineering loop used by the godmode1 plugin. Consult when implementing any non-trivial code change so the work stays gated, verified, and project-aware. Covers understand, plan, dependency-check, execute, self-review, bug-hunt, and optimize, all driven by godmode.config.json.
---

# godmode1 workflow

The loop is **understand -> plan -> dependencies -> execute -> review -> bug-hunt -> optimize**.
It is gated: a later step never runs until the earlier gate passes.

## Operating principles
- **Config first.** Always read `godmode.config.json` at the project root. Resolve every
  `"auto"` value by inspecting the repo before acting. Nothing is hardcoded to a stack.
- **Smallest verifiable change.** Plan in steps each independently testable.
- **Correctness before speed.** Optimization is the last step and only after tests pass.
- **Fail loud.** Surface risks and blockers up front; do not bury them under summaries.
- **Respect guardrails.** Never touch paths in `guardrails.never_touch`; confirm before
  destructive ops; do not push protected branches.

## When to use which entry point
- Full task, start to finish -> `/godmode <task>`
- Just design / get approval, no code -> `/plan <task>`
- Inspect existing work -> `/review [target]` (delegates to code-reviewer + bug-hunter)
- Speed/cleanup pass on working code -> `/optimize [area]`

## Customizing per project
Copy `godmode.config.json` into a new repo and set: project summary, the real
`commands.*` (or leave auto), `workflow.enabled_steps`, `strictness`, and `guardrails`.
That single file re-skins the entire workflow for any language or stack.
