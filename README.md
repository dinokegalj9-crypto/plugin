# plugin

Home of the **godmode1** Claude Code plugin and its marketplace index.

## Quick start

```bash
# 1. Register the marketplace
/plugin marketplace add dinokegalj9-crypto/plugin

# 2. Install the plugin
/plugin install godmode1@1.0.0 --user   # user scope
# or
/plugin install godmode1@1.0.0          # project scope

# 3. Use it
/godmode1 <task>
```

## Contents

| Path | What it is |
|---|---|
| `godmode1/` | The plugin — skills, package manifest |
| `godmode1-marketplace/` | Marketplace index Claude Code reads during `/plugin marketplace add` |

## godmode1 at a glance

`/godmode1 [task]` runs an autonomous, end-to-end agentic loop:
plan → act → verify → commit.  
Prompts only before destructive or irreversible operations.
