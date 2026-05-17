# CodeRabbit not commenting? Fix checklist

PR: https://github.com/bsunders/codeRabbit-test/pull/1

## 1. Install the app (most common miss)

1. Open https://github.com/apps/coderabbitai
2. Click **Configure** (or **Install**)
3. Under repository access, ensure **`codeRabbit-test`** is selected (not only other repos)
4. Click **Save** / **Install & Authorize**

## 2. Log in at CodeRabbit

1. https://app.coderabbit.ai/login → **Login with GitHub**
2. Same account as repo owner (`bsunders`)
3. Dashboard should list **codeRabbit-test**

## 3. Retrigger the review

After the app is installed, either:

- Push any new commit to `feature/flaky-utils`, **or**
- On PR #1, add a comment:

  ```
  @coderabbitai review
  ```

## 4. GitHub repo settings (if still silent)

**Settings → General → Pull Requests** — ensure PRs are enabled.

**Settings → Integrations → Applications → CodeRabbit → Configure** — repo must be checked.

**Settings → Code security** — if **“Limit who can approve or request changes”** is on, add CodeRabbit or turn it off (see CodeRabbit KB).

## 5. Confirm it worked

You should see a bot comment from **coderabbitai** or **coderabbit[bot]** within a few minutes.

No comments + no checks on the PR = app not installed on this repository yet.
