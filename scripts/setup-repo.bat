@echo off
setlocal EnableExtensions
cd /d "%~dp0.."

echo === GitHub auth ===
gh auth status
if errorlevel 1 (
  echo gh is not logged in. Run: gh auth login
  exit /b 1
)

for /f "delims=" %%i in ('gh api user -q .login') do set LOGIN=%%i
echo Logged in as: %LOGIN%

if not exist .git (
  git init
  git branch -M main
)

git checkout -B main
git add README.md package.json .gitignore src\index.js src\utils.js test\ data\sample.json scripts\setup-repo.ps1 scripts\setup-repo.bat
git commit -m "Initial CodeRabbit test sandbox (clean baseline)"
if errorlevel 1 echo Main commit skipped or already exists.

git checkout -B feature/flaky-utils
git add src\userLookup.js src\routes.js
git commit -m "Add user lookup utilities (intentional issues for review)"
if errorlevel 1 (
  echo Feature branch commit failed.
  exit /b 1
)

gh repo view %LOGIN%/codeRabbit-test >nul 2>&1
if errorlevel 1 (
  echo Creating remote repo...
  gh repo create codeRabbit-test --public --description "CodeRabbit PR review test sandbox" --source . --remote origin --push
) else (
  git remote get-url origin >nul 2>&1
  if errorlevel 1 git remote add origin https://github.com/%LOGIN%/codeRabbit-test.git
  git push -u origin main
  git push -u origin feature/flaky-utils
)

echo.
echo === Open PR ===
gh pr create --base main --head feature/flaky-utils --title "Add user lookup utilities (intentional issues for review)" --body "Test PR for CodeRabbit - contains deliberate security and quality issues. See README for planted issues list."

echo.
echo Repo: https://github.com/%LOGIN%/codeRabbit-test
endlocal
