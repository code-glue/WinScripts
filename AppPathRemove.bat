@echo off

:: %License%

SetLocal EnableDelayedExpansion

set FileName=%~n0

if [%1] == [] goto UI
if "%~1" == "/?" goto Usage
if not [%2] == [] goto Usage

goto CheckPath


:GetExeName
if "%%~n1" == "" exit /b 1
set Extension=%~x1
if "!Extension!" == "" set Extension=.exe
set ExeName=%~n1!Extension!
exit /b 0


:PrintHeader
echo.
echo Prevents a program/file from being opened from the "Run" dialog window using its alias.
echo Author: Ben Lemmond benlemmond@codeglue.org
exit /b


:UI
call :PrintHeader


:EnterAlias
echo.
set /p ExeName=Enter exe file name [Ctrl+C to exit]: 
if ErrorLevel 1 set "ExeName=" & verify>nul

:: Remove spaces
set ExeName=%ExeName: =%

if "%ExeName%" == "" goto EnterAlias
if "%ExeName%" == "." goto EnterAlias
if "%ExeName%" == ".." goto EnterAlias


:CheckPath
call :GetExeName %ExeName%
set RegKey=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\%ExeName%

reg query "%RegKey%" >NUL 2>1
if not ErrorLevel 0 {
    echo.
    echo Invalid key name: "%RegKey%"
    exit /b
)


:RegDelete
REM echo ExeName = '%ExeName%'
REM echo RegKey  = '%RegKey%'

reg delete "%RegKey%" /f
exit /b

echo.
echo Registry key not found: "%RegKey%"

exit /b


:Usage
call :PrintHeader
echo.
echo.%FileName% Alias[.exe]
echo.
echo.  Alias  The name of the alias to remove, optionally followed by ".exe".
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
