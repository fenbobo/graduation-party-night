@echo off
cd /d "C:\Users\dd197\Documents\Codex\2026-06-10\new-chat"
set "PATH=C:\Program Files\Git\bin;C:\Program Files\Git\cmd;%PATH%"
set "TOKEN=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"

:: Add safe directory
git config --global --add safe.directory "C:/Users/dd197/Documents/Codex/2026-06-10/new-chat" 2>nul

:: Push to GitHub
echo ===== Pushing to GitHub =====
git push -u origin https://fenbobo:%TOKEN%@github.com/fenbobo/graduation-party-night.git main
if %ERRORLEVEL% neq 0 (
    echo Push failed!
    pause
    exit /b 1
)

:: Enable GitHub Pages via API
echo ===== Enabling GitHub Pages =====
powershell -Command "Invoke-RestMethod -Uri 'https://api.github.com/repos/fenbobo/graduation-party-night/pages' -Method Post -Headers @{'Authorization'='Bearer %TOKEN%';'Accept'='application/vnd.github+json'} -Body '{\"source\":{\"branch\":\"main\",\"path\":\"/\"}}' -ContentType 'application/json'"

:: Clean up token from git config
git remote set-url origin https://github.com/fenbobo/graduation-party-night.git

echo ===== Done! =====
echo Your site: https://fenbobo.github.io/graduation-party-night/
echo It may take 1-2 minutes to go live.
pause
