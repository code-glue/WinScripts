@echo off

:: %License%

SetLocal DisableDelayedExpansion

set Result=1
 
if not [%1] == [] call :Usage & goto Exit

taskkill /im adb.exe /f 2>nul
if %ErrorLevel% neq 0 (
    if %ErrorLevel% neq 128 goto Exit
)

adb start-server
if %ErrorLevel% equ 0 set Result=0
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
