@echo off

:: %License%

SetLocal

set Result=1
set FileName=%~n0
set PauseOnError=%~dp0PauseOnError.bat

if [%1] == [] goto UI
if "%~1" == "/?" goto Usage
if not [%2] == [] goto Usage
if /i "%~1" == "/q" goto Restart


:UI
call :PrintHeader


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
goto ExitResult


:PrintHeader
echo.
echo Restarts explorer.exe.
echo.
exit /b 0


:Usage
call :PrintHeader
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
goto Exit


:ExitResult
if %Result% neq 0 call "%PauseOnError%"


:Exit
@%ComSpec% /c exit %Result% >nul
