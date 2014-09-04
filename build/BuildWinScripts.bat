@echo off

echo Building deployment package...
powershell -NoProfile -NonInteractive -Command "%~dp0%~n0.ps1 -Zip -ErrorAction Stop"
if errorlevel 1 pause & exit /b

echo.
echo Success
ping 1.1.1.1 -n 1 -w 2000 > nul

