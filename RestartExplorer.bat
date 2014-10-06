@echo off

:: %License%

SetLocal DisableDelayedExpansion

set Result=1

if [%1] == [] goto Confirm
if "%~1" == "/?" call :Usage & goto Exit
if not [%2] == [] call :Usage & goto Exit
if /i "%~1" == "/q" goto Restart


:Confirm
echo Continuing will close all of your Windows Explorer windows.
set /p Continue="Continue? [y/n]: " %=%
if %ErrorLevel% neq 0 set "Continue=" & verify >nul
if /i "%Continue%" == "y" goto Restart
if /i "%Continue%" == "n" goto Exit
goto Confirm


:Restart
echo.
echo Restarting explorer.exe ...
taskkill /im explorer.exe /f >nul
if %ErrorLevel% equ 0 set Result=0
start explorer
goto Exit


:Usage
echo.
echo Restarts explorer.exe.
echo.
echo.%~n0 [/Q]
echo.
echo.  /Q    Quiet mode, do not ask if ok to restart explorer.exe.
echo.
echo.Examples:
echo.
echo.  C:\^>%~n0
echo.    Prompts to restart explorer.exe.
echo.
echo.  C:\^>%~n0 /q
echo.    Restarts explorer.exe without prompting.
exit /b


:Exit
call "%~dp0PauseGui.bat" "%~f0"
@%ComSpec% /c exit %Result% >nul
