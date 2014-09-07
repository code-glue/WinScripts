@echo off

:: %License%

SetLocal

set Result=1
set FileName=%~n0
set PauseOnError=%~dp0PauseOnError.bat
 
if not [%1] == [] goto Usage

taskkill /im adb.exe /f 2>nul
if %ErrorLevel% neq 0 goto ExitResult

adb start-server
if %ErrorLevel% equ 0 set Result=0
goto ExitResult


:Usage
echo.
echo Kills all instances of adb.exe and restarts it.
echo.
echo.%FileName% ^<No Parameters^>
goto Exit


:ExitResult
if %Result% neq 0 call "%PauseOnError%"


:Exit
@%ComSpec% /c exit %Result% >nul
