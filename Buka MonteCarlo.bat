@echo off
setlocal
cd /d "%~dp0"
set "NODE=%ProgramFiles%\nodejs\node.exe"
if not exist "%NODE%" set "NODE=node"

curl.exe -fsS -o NUL --max-time 2 http://127.0.0.1:8080/
if not errorlevel 1 goto open

echo Menyalakan MonteCarlo Pro...
start "MonteCarlo Pro" /MIN /D "%~dp0" "%NODE%" scripts\with-app-env.mjs "%NODE%" node_modules\vite\bin\vite.js dev --host 127.0.0.1 --port 8080

for /l %%i in (1,1,45) do (
  curl.exe -fsS -o NUL --max-time 2 http://127.0.0.1:8080/
  if not errorlevel 1 goto open
  timeout /t 1 /nobreak >nul
)

echo Aplikasi belum menjawab. Tutup jendela ini, lalu klik ikonnya sekali lagi.
pause
exit /b 1

:open
start "" http://127.0.0.1:8080/
exit /b 0
