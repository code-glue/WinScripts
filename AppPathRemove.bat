@echo off

:: %License%

SetLocal EnableDelayedExpansion

set Here=%~dp0
set ExeName=%~1
set FileName=%~n0
set UI=0

if [%1] == [] goto UI
if "%~1" == "/?" goto Usage
if not [%2] == [] goto Usage

goto RegQuery


:GetExeName
set Extension=%~x1
if "%~x1" == "" set Extension=.exe
set ExeName=%~n1!Extension!
exit /b 0


:PrintHeader
echo.
echo Prevents a program/file from being opened from the "Run" dialog window using its alias.
exit /b 0


:UI
set UI=1
call :PrintHeader
echo.


:EnterAlias
set /p ExeName="Enter alias name to remove [Ctrl^+C to exit]: " %=%
if %ErrorLevel% neq 0 set "ExeName=" & verify >nul & goto EnterAlias

:: Remove spaces
set ExeName=%ExeName: =%

if "%ExeName%" == "" goto :EnterAlias
if "%ExeName%" == "." goto EnterAlias
if "%ExeName%" == ".." goto EnterAlias

:RegQuery
call :GetExeName "%ExeName%"
set RegKey=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\%ExeName%
reg query "%RegKey%" >nul
if %ErrorLevel% neq 0 goto ExitError


:RegDelete
reg delete "%RegKey%" /f >nul
if %ErrorLevel% neq 0 goto ExitError
echo Alias removed
exit /b 0


:ExitError
echo %RegKey% 1>&2
echo.
if %UI% equ 0 call "%Here%PauseOnError.bat"
exit /b 1


:Usage
call :PrintHeader
echo.
echo.%FileName% Alias[.exe]
echo.
echo.  Alias    The name of the alias to remove, optionally followed by ".exe".
echo.
echo.Examples:
echo.
echo.  C:\^>%FileName%
echo.    Prompts for the alias.
echo.
echo.  C:\^>%FileName% "npp"
echo.    Removes the "npp.exe" alias from the registry.
echo.
echo.  C:\^>%FileName% "npp.exe"
echo.    Removes the "npp.exe" alias from the registry.
exit /b
