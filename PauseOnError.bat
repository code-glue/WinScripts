@echo off

:: %License%

SetLocal

set PauseOnError=1
set ScriptName=%~n0

if not [%1] == [] goto Usage

if not %PauseOnError% equ 0 pause
goto Exit

:Usage
echo.
echo Pauses the console if %%PauseOnError%% is set to 1; otherwise, does nothing.
echo.
echo.%ScriptName% ^<No Parameters^>


:Exit
@%ComSpec% /c exit 0 >nul
