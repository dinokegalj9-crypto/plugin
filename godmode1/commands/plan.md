---
description: Run only the planning phase of godmode1 (understand -> plan -> dependencies). No code written.
argument-hint: <task to plan>
---

Read `godmode.config.json`. Plan-only mode: you will NOT write or edit code.

Task: **$ARGUMENTS**

1. **Understand** — map the project, restate the task, list known + unknown requirements.
2. **Plan** — smallest sequence of verifiable steps; per step list files, change, verification.
3. **Dependencies & conflicts** — new libs (justified), version risks, code collisions,
   anything in `guardrails.never_touch`.

Output a numbered, approval-ready plan and an explicit risk list. Then stop and ask:
"Approve this plan, or revise?" Write no code until approved.
