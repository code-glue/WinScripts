@echo off

:: %License%

SetLocal

set Result=1
set ScriptName=%~n0
set PauseOnError=%~dp0PauseOnError.bat

if [%1] == [] goto UI
if "%~1" == "/?" goto Usage
if not [%2] == [] goto Usage
if /i "%~1" == "/q" goto Restart


:UI
echo Continuing will close all of your Windows Explorer windows.
set /p Continue="Continue? [y/n]: " %=%
if %ErrorLevel% neq 0 set "Continue=" & verify >nul
if /i "%Continue%" == "y" goto Restart
if /i "%Continue%" == "n" goto Exit
goto UI


:Restart
echo.
echo Restarting explorer.exe ...
taskkill /im explorer.exe /f >nul
if %ErrorLevel% equ 0 set Result=0
start explorer
goto ExitResult


:PrintHeader
exit /b 0


:Usage
echo.
echo Restarts explorer.exe.
echo.
echo.%ScriptName% [/Q]
echo.
echo.  /Q    Quiet mode, do not ask if ok to restart explorer.exe.
echo.
echo.Examples:
echo.
echo.  C:\^>%ScriptName%
echo.    Prompts to restart explorer.exe.
echo.
echo.  C:\^>%ScriptName% /q
echo.    Restarts explorer.exe without prompting.
goto Exit


:ExitResult
if %Result% neq 0 call "%PauseOnError%"


:Exit
@%ComSpec% /c exit %Result% >nul
