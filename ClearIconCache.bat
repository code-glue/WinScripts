@echo off

:: %License%


REM This may work only in Vista (SP2?) and up.
REM It may not even be relevant for Windows 8.

SetLocal

set Result=1
set FileName=%~n0
set PauseOnError=%~dp0PauseOnError.bat

if not [%1] == [] goto Usage

ie4uinit.exe -ClearIconCache
if %ErrorLevel% equ 0 set Result=0
goto ExitResult


:Usage
echo Clears the icon cache by running this command:
echo.    ie4uinit.exe -ClearIconCache
echo.
echo.%FileName% ^<No Parameters^>
goto Exit


:ExitResult
if %Result% neq 0 call "%PauseOnError%"


:Exit
@%ComSpec% /c exit %Result% >nul
