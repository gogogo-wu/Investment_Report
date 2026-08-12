@echo off
REM ============================================================
REM One-click: stage all changes, commit with timestamp, push
REM to GitHub (gogogo-wu/Investment_Report).
REM Usage: double-click this file, or run it from terminal.
REM ============================================================
cd /d "%~dp0"

REM Build a numeric timestamp for the commit message
set Y=%date:~0,4%
set M=%date:~5,2%
set D=%date:~8,2%
set T=%time:~0,2%%time:~3,2%
set TS=%Y%%M%%D%_%T%

git add -A
git commit -m "update %TS%"
git push origin main

echo.
echo Done. If you saw "nothing to commit", there were no changes.
pause
