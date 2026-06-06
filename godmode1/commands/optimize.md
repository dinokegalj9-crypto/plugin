---
description: Run godmode1 optimization pass — only after functionality is confirmed.
argument-hint: [path or area to optimize]
---

Read `godmode.config.json`. Optimization mode over: **$ARGUMENTS**.

PRECONDITION: refuse to start unless tests currently pass (run `commands.test`).
If they fail, stop and say so — optimization never precedes correctness.

1. Clarity first: naming, structure, dead code, duplication.
2. Performance only where it measurably matters — show the hot path / cost reasoning.
3. Preserve behaviour: re-run tests after each change; revert anything that breaks them.

Report before/after for each change and confirm the test suite still passes.
