@echo off

echo Building deployment package...
powershell -NoProfile -NonInteractive -Command "%~dp0%~n0.ps1 -ScriptDir .. -OutputDir ..\Download -Zip -ErrorAction Stop"
if %ErrorLevel% neq 0 pause & exit /b 1

echo.
echo Success
ping 1.1.1.1 -n 1 -w 2000 > nul

