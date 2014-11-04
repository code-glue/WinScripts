@echo off

:: %License%

SetLocal DisableDelayedExpansion & set Result=%ErrorLevel%

set Arg1=%1

SetLocal EnableDelayedExpansion
if not .!Arg1! == . EndLocal & call :Usage & (set Result=1) & goto Exit
EndLocal

:DoWork
echo | (set /p=) >con
goto Exit


:Usage
echo.Plays the sound of the bell control signal (ASCII character 7).
echo.
echo.%~n0 ^<No Parameters^>
exit /b

:Exit
@%ComSpec% /c exit %Result% >nul
