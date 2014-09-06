@echo off

:: %License%

SetLocal

set Result=1
set PauseOnError=%~dp0PauseOnError.bat

if "%1" == "/?" goto Usage
if not [%1] == [] goto Usage


taskkill /im adb.exe /f 2>nul
if %ErrorLevel% neq 0 goto Exit

adb start-server
if %ErrorLevel% equ 0 set Result=0
goto Exit


:Usage
echo. Kills all instances of adb.exe and restarts it.
echo.
echo.%FileName% <No Parameters>


:Exit
if %Result% neq 0 call "%PauseOnError%"
@%ComSpec% /c exit %Result% >nul
