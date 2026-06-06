---
description: Run the full godmode1 disciplined workflow on a task (all 7 steps, gated).
argument-hint: <what you want built or changed>
---

You are operating in **godmode1**: a disciplined, gate-driven engineering loop.
Read `godmode.config.json` from the project root first. If absent, use sane defaults
and tell the user you are running with defaults. Resolve every `"auto"` value by
inspecting the repo (manifest files, lockfiles, existing scripts) before acting.

The task: **$ARGUMENTS**

Run these steps **in order**. Do not skip ahead. Honor `workflow.enabled_steps`,
`workflow.strictness`, and `workflow.stop_on_first_failing_gate` from config.

## 1. Understand
- Map the project: entry points, structure, build/test commands, conventions.
- Restate the task in your own words and list explicit + implicit requirements.
- List what you DON'T yet know. If a knowledge gap would change the design, ask now.
- GATE: produce a short "understanding summary." Do not plan until it is coherent.

## 2. Plan
- Break the task into the smallest sequence of verifiable changes.
- For each step: which files, what changes, how you'll verify it.
- Respect `workflow.max_files_per_change`.
- GATE: if `require_plan_approval` is true, present the plan and STOP for approval.

## 3. Dependencies & conflicts
- List new libraries (justify each; prefer the stdlib / existing deps first).
- Flag version conflicts, breaking API changes, and collisions with existing code.
- Check `guardrails.never_touch` and `protected_branches` — refuse changes there.
- GATE: surface every risk before writing code.

## 4. Execute
- Implement one planned step at a time. Follow `conventions` and existing style.
- Keep diffs minimal and readable. No drive-by refactors.
- After each step, state what you changed and why.

## 5. Review (self)
- Walk `review.checklist` from config item by item, honestly.
- Re-read your own diff as if reviewing a stranger's PR.
- GATE: if strictness is "high" and any checklist item fails, fix before continuing.

## 6. Bug hunt & edge cases
- Enumerate edge cases: empty/null, boundary values, concurrency, failure paths,
  large input, unexpected types, partial state.
- Run `commands.test` (and `lint`/`typecheck` if set). Report real output.
- GATE: do not proceed to optimize until functionality is confirmed working.

## 7. Optimize
- Only now. Improve clarity, then performance where it measurably matters.
- Never trade correctness or readability for micro-optimizations.
- State before/after reasoning for each optimization.

End with a concise report: what was built, what was verified, what is still risky.
