---
description: Run godmode1 review + bug-hunt on current changes or a target path.
argument-hint: [path or "staged" or "last change"]
---

Read `godmode.config.json`. Review mode over: **$ARGUMENTS** (default: uncommitted changes).

Use the `code-reviewer` and `bug-hunter` agents if available.

1. **Self-review** — walk `review.checklist` item by item, verdict + evidence for each.
2. **Bug hunt** — edge cases: empty/null, boundaries, concurrency, failure paths,
   large/malformed input, partial state. List each with severity (blocker/major/minor).
3. **Verify** — run `commands.test`, `lint`, `typecheck` from config; paste real results.

If `review.fail_loud` is true, lead with the worst finding, not a summary of praise.
End with: BLOCKERS (must fix), SHOULD-FIX, NICE-TO-HAVE.
