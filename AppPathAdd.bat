@echo off
    
setlocal EnableDelayedExpansion

set FileName=%~n0
set ExePath=%~f1
set ExeDir=%~dp1
set Alias=%~n2

if [%1] == [] goto ui
if "%~1" == "/?" goto Usage
if not [%3] == [] goto Usage

call :CheckPath
if errorlevel 1 exit /b

goto RegAdd
    
:CheckPath
if exist "%ExePath%" (2>nul pushd "%ExePath%" && (popd&set "FileType=FOLDER") || set "FileType=FILE" ) else set "FileType=INVALID"

if %FileType% == INVALID (
    call :PrintInvalidPath
    exit /b 1
)

if %FileType% == FOLDER (
    call :PrintInvalidPath
    echo Path is a directory.
    exit /b 1
)
exit /b 0

:PrintInvalidPath
echo.
echo Invalid path: "!ExePath!"
exit /b

:PrintHeader
echo.
echo Makes programs or files accessible from the Start-^>Run dialog window.
echo Author: Ben Lemmond benlemmond@codeglue.org
echo.
exit /b

:ui
call :PrintHeader

:enterpath
:: Prompt the user for the path
set /p ExePath=Enter path to exe file [Ctrl+C to exit]: %=%
if errorlevel 1 set "ExePath=" & verify>nul

if [!ExePath!] == [] (
    goto enterpath
)

:: Remove quotes
set ExePath=%ExePath:"=%

if [!ExePath!] == [] (
    goto enterpath
)

:: Expand variables
for %%a in ("!ExePath!") do (
    call set ExePath=%%~a
    call :CheckPath
    if errorlevel 1 exit /b
)

:: Prompt the user for the alias
set /p Alias=Enter Alias. Press Enter to use the file name [Ctrl+C to exit]: 
if errorlevel 1 set "Alias=" & verify>nul

goto RegAdd

:RegAdd
for %%a in ("%ExePath%") do (
    set ExeDir=%%~dpa
)

:: Remove trailing slash
if %ExeDir:~-1%==\ set ExeDir=%ExeDir:~0,-1%

:: Default to filename if no alias is specified
if "%Alias%" == "" (
    for %%a in ("%ExePath%") do set Alias=%%~na
) else (
    for %%a in ("%Alias%") do set Alias=%%~na
)

set RegKey=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\%Alias%.exe

echo ExePath  = %ExePath%
echo ExeDir   = %ExeDir%
echo Alias    = %Alias%
echo RegKey   = %RegKey%

reg add "%RegKey%" /f /ve /d "%ExePath%"
reg add "%RegKey%" /f /v "Path" /d "%ExeDir%"

exit /b

:Usage
call :PrintHeader
echo.%FileName% [ExePath [Alias]]
echo.
echo.  ExePath  Path to the executable file that will be run.
echo.  Alias    Name that will be entered into the Run dialog window.
echo.           If excluded, defaults to the executable file name.
echo.
echo.Examples:
echo.
echo.  %FileName%
echo.    -^> Prompts for the executable file path and alias.
echo.
echo.  %FileName% "C:\Program Files (x86)\NotePad++\notepad++.exe"
echo.    Runs Notepad++ when "notepad++" or "notepad++.exe" is entered.
echo.
echo.  %FileName% "%%SystemRoot%%\system32\WindowsPowerShell\v1.0\PowerShell.exe" posh
echo.    Runs PowerShell when "posh" or "posh.exe" is entered.
exit /b
