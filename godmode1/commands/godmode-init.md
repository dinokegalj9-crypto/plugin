---
description: Bootstrap godmode1 into the current project — auto-detect the stack and write godmode.config.json.
argument-hint: [optional one-line project summary]
---

You are initializing **godmode1** in this repository so it can be "applied everywhere"
with zero manual setup. Project summary (optional): **$ARGUMENTS**

## 1. Detect the stack (read, don't guess)
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

Also: read any existing `scripts`/`tasks` in the manifest and PREFER the project's real
script names over the defaults above. Detect `project.type` from structure (presence of
`src/components` + a frontend framework -> web-frontend; an HTTP server entry -> backend-api;
a `bin`/CLI entry -> cli; only a library export -> library; etc.).

## 2. Detect guardrails
- Find protected branches from CI config / git if available; default to `main`, `master`.
- Add real secret/build paths to `never_touch` (e.g. `.env*`, `dist/`, `target/`, `build/`, `vendor/`).

## 3. Write the config
- If `godmode.config.json` already exists: show a diff of proposed changes and ask before overwriting.
- Otherwise write it, filling every value you detected and leaving `"auto"` only where genuinely unknown.
- Set `project.summary` from $ARGUMENTS or infer one sentence from the README.

## 4. Report
Print the detected stack, the commands you wired, anything left as `auto`, and tell the
user exactly which fields to review. End by suggesting `/plan <first task>`.
