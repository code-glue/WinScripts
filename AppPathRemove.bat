@echo off

:: %License%

SetLocal EnableDelayedExpansion

set ExeName=%~1
set FileName=%~n0

if [%1] == [] goto UI
if "%~1" == "/?" goto Usage
if not [%2] == [] goto Usage

goto CheckPath


:GetExeName
if [%~n1] == [] exit /b 1
set Extension=%~x1
if "%~x1" == "" set Extension=.exe
set ExeName=%~n1!Extension!
exit /b 0


:PrintHeader
echo.
echo Prevents a program/file from being opened from the "Run" dialog window using its alias.
exit /b


:UI
call :PrintHeader


:EnterAlias
echo.
set /p ExeName=Enter alias name to remove [Ctrl+C to exit]:
if ErrorLevel 1 set "ExeName=" & verify>nul

:: Remove spaces
set ExeName=%ExeName: =%

if "%ExeName%" == "" goto EnterAlias
if "%ExeName%" == "." goto EnterAlias
if "%ExeName%" == ".." goto EnterAlias


:CheckPath
call :GetExeName "%ExeName%"
set RegKey=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\%ExeName%

reg query "%RegKey%" >nul
REM echo ErrorLevel=%ErrorLevel%
REM if not ErrorLevel 0 (
if not "%ErrorLevel%" == "0" (
    echo %RegKey% 1>&2
    exit /b
)


:RegDelete
REM echo ExeName = '%ExeName%'
REM echo RegKey  = '%RegKey%'

reg delete "%RegKey%" /f >nul
if ErrorLevel 0 echo Alias removed
exit /b


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
