---
description: godmode1 — disciplined engineering workflow. Subcommands: init, plan, review, optimize, or run the full 7-step loop on a task.
argument-hint: init | plan <task> | review [path] | optimize [path] | <task>
---

Read `godmode.config.json` from the project root first. If absent, use sane defaults
and note that you are running without config. Resolve every `"auto"` value by
inspecting the repo before acting.

Arguments: **$ARGUMENTS**

Dispatch on the FIRST word of $ARGUMENTS:

---

## `init` — bootstrap this project

Bootstrap godmode1 into the current project. Project summary (optional): rest of $ARGUMENTS.

### 1. Detect the stack (read, don't guess)
Inspect the repo root and infer values using this table. Use the FIRST match found:

| Signal file | language | package_manager | install | build | test | lint | run |
|---|---|---|---|---|---|---|---|
| `package.json` (has `pnpm-lock.yaml`) | js/ts | pnpm | `pnpm i` | `pnpm build` | `pnpm test` | `pnpm lint` | `pnpm dev` |
| `package.json` (has `yarn.lock`) | js/ts | yarn | `yarn` | `yarn build` | `yarn test` | `yarn lint` | `yarn dev` |
| `package.json` (else) | js/ts | npm | `npm i` | `npm run build` | `npm test` | `npm run lint` | `npm run dev` |
| `pyproject.toml` (has `uv.lock`) | python | uv | `uv sync` | — | `uv run pytest` | `uv run ruff check` | `uv run` |
| `pyproject.toml`/`poetry.lock` | python | poetry | `poetry install` | — | `poetry run pytest` | `poetry run ruff check` | `poetry run` |
| `requirements.txt` | python | pip | `pip install -r requirements.txt` | — | `pytest` | `ruff check` | `python` |
| `Cargo.toml` | rust | cargo | `cargo fetch` | `cargo build` | `cargo test` | `cargo clippy` | `cargo run` |
| `go.mod` | go | go | `go mod download` | `go build ./...` | `go test ./...` | `go vet ./...` | `go run .` |
| `pom.xml` | java | maven | `mvn install` | `mvn package` | `mvn test` | — | `mvn exec:java` |
| `build.gradle*` | java/kotlin | gradle | `./gradlew build` | `./gradlew build` | `./gradlew test` | `./gradlew check` | `./gradlew run` |
| `Gemfile` | ruby | bundler | `bundle install` | — | `bundle exec rspec` | `bundle exec rubocop` | `bundle exec` |
| `composer.json` | php | composer | `composer install` | — | `composer test` | — | `php` |
| none of the above | other | unknown | leave `auto` | leave `auto` | leave `auto` | leave `auto` | leave `auto` |

Prefer the project's real script names over defaults. Detect `project.type` from structure.

### 2. Detect guardrails
Find protected branches from CI config / git; default to `main`, `master`. Add real
secret/build paths to `never_touch` (`.env*`, `dist/`, `target/`, `build/`, `vendor/`).

### 3. Write the config
If `godmode.config.json` already exists: show a diff and ask before overwriting.
Otherwise write it, filling every detected value, leaving `"auto"` only where unknown.

### 4. Report
Print detected stack, wired commands, anything left as `auto`, fields to review.
End by suggesting `/godmode1 plan <first task>`.

---

## `plan <task>` — plan only, no code written

Task: rest of $ARGUMENTS.

1. **Understand** — map the project, restate the task, list known + unknown requirements.
2. **Plan** — smallest sequence of verifiable steps; per step list files, change, verification.
3. **Dependencies & conflicts** — new libs (justified), version risks, collisions, `guardrails.never_touch`.

Output a numbered, approval-ready plan and an explicit risk list. Stop and ask:
"Approve this plan, or revise?" Write no code until approved.

---

## `review [path]` — review + bug hunt

Target: rest of $ARGUMENTS (default: uncommitted changes).

Use `code-reviewer` and `bug-hunter` agents if available.

1. **Self-review** — walk `review.checklist` item by item, verdict + evidence for each.
2. **Bug hunt** — edge cases: empty/null, boundaries, concurrency, failure paths, large/malformed input, partial state. Each finding gets a severity: blocker / major / minor.
3. **Verify** — run `commands.test`, `lint`, `typecheck` from config; paste real results.

If `review.fail_loud` is true, lead with the worst finding.
End with: BLOCKERS, SHOULD-FIX, NICE-TO-HAVE.

---

## `optimize [path]` — optimize pass (only after tests pass)

Target: rest of $ARGUMENTS.

PRECONDITION: refuse to start unless tests currently pass (run `commands.test`).
If they fail, stop and say so.

1. Clarity first: naming, structure, dead code, duplication.
2. Performance only where measurably matters — show hot path / cost reasoning.
3. Preserve behaviour: re-run tests after each change; revert anything that breaks them.

Report before/after for each change and confirm the test suite still passes.

---

## `<anything else>` — full 7-step loop

Task: $ARGUMENTS. Run these steps in order. Honor `workflow.enabled_steps`,
`workflow.strictness`, and `workflow.stop_on_first_failing_gate` from config.

### 1. Understand
Map the project: entry points, structure, build/test commands, conventions.
Restate the task in your own words, list explicit + implicit requirements.
List what you DON'T yet know. If a gap would change the design, ask now.
GATE: produce a short understanding summary. Do not plan until it is coherent.

### 2. Plan
Break the task into the smallest sequence of verifiable changes.
For each step: which files, what changes, how you'll verify it.
Respect `workflow.max_files_per_change`.
GATE: if `require_plan_approval` is true, present the plan and STOP for approval.

### 3. Dependencies & conflicts
List new libraries (justify each; prefer stdlib / existing deps first).
Flag version conflicts, breaking API changes, collisions with existing code.
Check `guardrails.never_touch` and `protected_branches` — refuse changes there.
GATE: surface every risk before writing code.

### 4. Execute
Implement one planned step at a time. Follow `conventions` and existing style.
Keep diffs minimal and readable. No drive-by refactors.
After each step, state what you changed and why.

### 5. Review (self)
Walk `review.checklist` from config item by item, honestly.
Re-read your own diff as if reviewing a stranger's PR.
GATE: if strictness is "high" and any checklist item fails, fix before continuing.

### 6. Bug hunt & edge cases
Enumerate edge cases: empty/null, boundary values, concurrency, failure paths,
large input, unexpected types, partial state.
Run `commands.test` (and `lint`/`typecheck` if set). Report real output.
GATE: do not proceed to optimize until functionality is confirmed working.

### 7. Optimize
Only now. Improve clarity, then performance where it measurably matters.
Never trade correctness or readability for micro-optimizations.
State before/after reasoning for each optimization.

End with a concise report: what was built, what was verified, what is still risky.
