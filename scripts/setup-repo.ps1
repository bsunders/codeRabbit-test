# Creates GitHub repo codeRabbit-test, main + feature branch, and opens a test PR.
# Requires: git, gh (authenticated via `gh auth login`)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot
Set-Location $Root

Write-Host "=== GitHub auth ===" -ForegroundColor Cyan
gh auth status
$login = gh api user -q .login
Write-Host "Logged in as: $login"

if (-not (Test-Path .git)) {
  git init
  git branch -M main
}

git checkout -B main 2>$null
git add README.md package.json .gitignore src/index.js src/utils.js test/ data/sample.json scripts/setup-repo.ps1 scripts/setup-repo.bat
git commit -m "Initial CodeRabbit test sandbox (clean baseline)" 2>$null
if ($LASTEXITCODE -ne 0) { Write-Host "Main commit skipped or empty (may already exist)" }

git checkout -B feature/flaky-utils
git add src/userLookup.js src/routes.js
git commit -m "Add user lookup utilities (intentional issues for review)"
if ($LASTEXITCODE -ne 0) { throw "Feature branch commit failed" }

$repo = "$login/codeRabbit-test"
gh repo view $repo 2>$null
if ($LASTEXITCODE -ne 0) {
  Write-Host "Creating remote repo..." -ForegroundColor Cyan
  gh repo create codeRabbit-test --public --description "CodeRabbit PR review test sandbox" --source . --remote origin --push
} else {
  git remote get-url origin 2>$null
  if ($LASTEXITCODE -ne 0) { git remote add origin "https://github.com/$repo.git" }
  git push -u origin main
  git push -u origin feature/flaky-utils
}

$prUrl = gh pr create `
  --base main `
  --head feature/flaky-utils `
  --title "Add user lookup utilities (intentional issues for review)" `
  --body "Test PR for CodeRabbit - deliberate security and quality issues for review bot testing."

Write-Host "`nDone!"
Write-Host "Repo: https://github.com/$repo"
Write-Host "PR:   $prUrl"
