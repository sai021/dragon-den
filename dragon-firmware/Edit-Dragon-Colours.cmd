@echo off
setlocal
cd /d "%~dp0"
set "DRAGON_PY=%USERPROFILE%\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe"
if exist "%DRAGON_PY%" (
  "%DRAGON_PY%" tools\palettes.py gui
) else (
  py tools\palettes.py gui
)
if errorlevel 1 pause
