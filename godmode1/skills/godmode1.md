# godmode1

Elevated Claude Code session: autonomous multi-step execution with deep reasoning, full-repo awareness, and minimal interruptions.

## Usage

```
/godmode1 [task]
```

With no argument: toggles godmode on for the current session (sets aggressive auto-approve posture and enables extended thinking).

With a task argument: executes the task end-to-end — plans, acts, verifies, commits — without stopping for confirmation unless a destructive or irreversible action is detected.

## What it does

1. **Plan** — breaks the task into numbered steps before touching any file
2. **Act** — executes each step, reading/writing/running as needed
3. **Verify** — runs tests or linters and fixes failures automatically
4. **Commit** — stages and commits with a clear message; prompts before push

## Posture

- Auto-approves read, write, and run tool calls
- Still prompts for: `git push --force`, `rm -rf`, credential writes, external HTTP mutations
- Uses extended thinking (budget: high) on any step touching architecture or security

## Examples

```
/godmode1 refactor the auth module to use JWT, update tests, commit
/godmode1 find all N+1 queries and fix them
/godmode1 add rate limiting to every public API endpoint
/godmode1
```
