@echo off

:: %License%


SetLocal EnableDelayedExpansion

set PauseOnError=%~dp0PauseOnError.bat
set FileExists=%~dp0FileExists.bat
set FileName=%~n0
set FilePath=%~f1
set ExeDir=%~dp1
set Alias=%~n2
set Result=1

if [%1] == [] goto UI
if "%~1" == "/?" goto Usage
if not [%3] == [] goto Usage

call "%FileExists%" "%FilePath%"
if %ErrorLevel% neq 0 goto PrintInvalidPath
goto RegAdd


:UI
call :PrintHeader


:EnterPath
:: Prompt the user for the path
set /p FilePath="Enter path to exe file [Ctrl+C to exit]: " %=%
if %ErrorLevel% neq 0 set "FilePath=" & verify>nul & goto EnterPath

:: Remove quotes
set FilePath=%FilePath:"=%

if [!FilePath!] == [] goto EnterPath

:: Expand path
for %%a in ("!FilePath!") do (
    call set FilePath=%%~fa
    call "%FileExists%" "!FilePath!"
    if !ErrorLevel! neq 0 goto PrintInvalidPath
)

:: Prompt the user for the alias
set /p Alias="Enter Alias. Leave blank to use the file name [Ctrl+C to exit]: " %=%
if %ErrorLevel% neq 0 set "Alias=" & verify>nul


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

reg add "%RegKey%" /f /ve /d "%FilePath%" >nul
reg add "%RegKey%" /f /v "Path" /d "%ExeDir%" >nul

if %ErrorLevel% equ 0 echo Alias added: "%Alias%" -^> "%FilePath%" & set Result=0
goto ExitPause


:PrintInvalidPath
echo.
echo %FileName%: File does not exist: %FilePath% 1>&2
echo.
goto ExitPause


:PrintHeader
echo.
echo Allows a program/file to be opened from the "Run" dialog window using an alias.
echo.
exit /b 0


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
goto Exit


:ExitPause
if !Result! neq 0 call "%PauseOnError%"


:Exit
@%ComSpec% /c exit !Result! >nul
