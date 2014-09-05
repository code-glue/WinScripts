@echo off

:: %License%
    
SetLocal EnableDelayedExpansion

set FileName=%~n0
set FilePath=%~f1
set ExeDir=%~dp1
set Alias=%~n2

if [%1] == [] goto UI
if "%~1" == "/?" goto Usage
if not [%3] == [] goto Usage

call :CheckPath
if errorlevel 1 exit /b

goto RegAdd
    
:CheckPath
if exist "%FilePath%" (2>nul pushd "%FilePath%" && (popd&set "FileType=FOLDER") || set "FileType=FILE" ) else set "FileType=INVALID"

if %FileType% == INVALID (
    call :PrintInvalidPath
    exit /b 1
)

if %FileType% == FOLDER (
    call :PrintInvalidPath
    echo Path is a directory. 1>&2
    exit /b 1
)
exit /b 0

:PrintInvalidPath
echo.
echo Invalid path: "!FilePath!" 1>&2
exit /b

:PrintHeader
echo.
echo Allows a program/file to be opened from the "Run" dialog window using an alias.
echo.
exit /b

:UI
call :PrintHeader

:EnterPath
:: Prompt the user for the path
set /p FilePath=Enter path to exe file [Ctrl+C to exit]: %=%
if errorlevel 1 set "FilePath=" & verify>nul

if [!FilePath!] == [] (
    goto EnterPath
)

:: Remove quotes
set FilePath=%FilePath:"=%

if [!FilePath!] == [] (
    goto EnterPath
)

:: Expand variables
for %%a in ("!FilePath!") do (
    call set FilePath=%%~a
    call :CheckPath
    if errorlevel 1 exit /b
)

:: Prompt the user for the alias
set /p Alias=Enter Alias. Press Enter to use the file name [Ctrl+C to exit]: 
if errorlevel 1 set "Alias=" & verify>nul

goto RegAdd

:RegAdd
for %%a in ("%FilePath%") do (
    set ExeDir=%%~dpa
)

:: Remove trailing slash
if %ExeDir:~-1%==\ set ExeDir=%ExeDir:~0,-1%

:: Default to filename if no alias is specified
if "%Alias%" == "" (
    for %%a in ("%FilePath%") do set Alias=%%~na
) else (
    for %%a in ("%Alias%") do set Alias=%%~na
)

set RegKey=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\%Alias%.exe

REM echo Alias    = %Alias%
REM echo FilePath = %FilePath%
REM echo ExeDir   = %ExeDir%
REM echo RegKey   = %RegKey%

reg add "%RegKey%" /f /ve /d "%FilePath%" >nul
reg add "%RegKey%" /f /v "Path" /d "%ExeDir%" >nul
if ErrorLevel 0 echo Alias added: "%Alias%" -^> "%FilePath%"

exit /b

:Usage
call :PrintHeader
echo.%FileName% [Path [Alias]]
echo.
echo.  Path   Path to the program/file that will be run/opened.
echo.  Alias  Name that will be entered into the Run dialog window.
echo.         If excluded, defaults to the file's name.
echo.
echo.Examples:
echo.
echo.  C:\^>%FileName%
echo.    Prompts for the file path and alias.
echo.
echo.  C:\^>%FileName% "C:\Program Files (x86)\NotePad++\notepad++.exe"
echo.    Runs Notepad++ when "notepad++" or "notepad++.exe" is entered.
echo.
echo.  C:\^>%FileName% "C:\Program Files (x86)\NotePad++\notepad++.exe" npp
echo.    Runs Notepad++ when "npp" or "npp.exe" is entered.
exit /b
