@echo off

:: %License%

REM This may work only in Vista (SP2?) and up.
REM It may not even be relevant for Windows 8.

ie4uinit.exe -ClearIconCache
if ErrorLevel 0 exit /b
pause
