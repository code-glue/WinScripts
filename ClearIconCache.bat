@echo off

:: %License%

REM This may work only in Vista (SP2?) and up.
REM It may not even be relevant for Windows 8.

SetLocal

set PauseOnError=%~dp0PauseOnError.bat
set Result=1

ie4uinit.exe -ClearIconCache
if %ErrorLevel% equ 0 set Result=0

if %ErrorLevel% neq 0 call "%PauseOnError%"
@%ComSpec% /c exit %Result% >nul
