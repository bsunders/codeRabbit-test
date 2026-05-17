# codeRabbitTest

Sandbox repo for testing [CodeRabbit](https://coderabbit.ai) PR reviews.

**Project path:** `C:\Users\bensu\OneDrive\Documents\code\codeRabbitTest`

## Intentional issues (for review bots)

The `feature/flaky-utils` branch introduces deliberate problems CodeRabbit should flag:

- SQL injection risk (string-concatenated query)
- Hardcoded API secret
- Missing error handling / swallowed exceptions
- Race-prone shared mutable state
- Insecure `eval`-style pattern
- N+1-style loop with redundant work

## Quick setup (creates GitHub repo + PR)

Requires [GitHub CLI](https://cli.github.com/) (`gh auth login`).

**Command Prompt (cmd):**

```cmd
cd /d C:\Users\bensu\OneDrive\Documents\code\codeRabbitTest
scripts\setup-repo.bat
```

**PowerShell:**

```powershell
cd C:\Users\bensu\OneDrive\Documents\code\codeRabbitTest
.\scripts\setup-repo.ps1
```

This will:

1. Commit a **clean** `main` branch (`src/index.js`, `src/utils.js`)
2. Commit **flawed** code on `feature/flaky-utils` (`src/userLookup.js`, `src/routes.js`)
3. Create `codeRabbit-test` on GitHub and open a PR

## CodeRabbit

Install the [CodeRabbit GitHub App](https://github.com/apps/coderabbitai) on this repo, then open the PR — it should comment on the planted issues.

## Local dev

```cmd
npm test
node src\index.js Ada
```

## Old copy

If you still have `C:\Users\bensu\codeRabbit-test`, delete it after confirming this folder works:

```cmd
rmdir /s /q C:\Users\bensu\codeRabbit-test
```
