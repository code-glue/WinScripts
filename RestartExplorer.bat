@echo off

:: %License%

SetLocal

set FileName=%~n0

if [%1] == [] goto UI
if "%~1" == "/?" goto Usage
if not [%2] == [] goto Usage
if /i "%~1" == "/q" goto Restart

:UI
echo.
echo Continuing will close all of your Windows Explorer windows.
set /p Continue="Continue? [y/n]: " %=%
if errorlevel 1 set "Continue=" & verify>nul
if /i "%Continue%" == "y" goto Restart
if /i "%Continue%" == "n" exit /b
goto UI


:Restart
echo.
echo Restarting explorer.exe ...
taskkill /im explorer.exe /f >nul
set Result=%ErrorLevel%
start explorer
if not "%Result%" == "0" pause & exit /b %Result%
exit /b


:Usage
echo Restarts explorer.exe.
echo.
echo.%FileName% [/Q]
echo.
echo.  /Q    Quiet mode, do not ask if ok to restart explorer.exe.
echo.
echo.Examples:
echo.
echo.  C:\^>%FileName%
echo.    Prompts to restart explorer.exe.
echo.
echo.  C:\^>%FileName% /q
echo.    Restarts explorer.exe without prompting.
exit /b
