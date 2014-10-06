@echo off

:: %License%

SetLocal DisableDelayedExpansion

set Result=1

SetLocal EnableDelayedExpansion
set Arg1=%1
if not .!Arg1! == . EndLocal & call :Usage & goto Exit
EndLocal


:DoWork
call "%~dp0KillAdb.bat"
if %ErrorLevel% neq 0 goto Exit

adb start-server
set Result=%ErrorLevel%
goto Exit


:Usage
echo.
echo Kills all instances of adb.exe and restarts it.
echo.
echo.%~n0 ^<No Parameters^>
exit /b


:Exit
call "%~dp0PauseGui.bat" "%~f0"
@%ComSpec% /c exit %Result% >nul
