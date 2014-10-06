@echo off

:: %License%


SetLocal DisableDelayedExpansion

set Result=1
goto BeginScript


:EnterFilePath
call :PrintHeader
:EnterFilePathSub
set /p "FilePath=Enter path to exe file [Ctrl+C to exit]: "
SetLocal EnableDelayedExpansion
if .!FilePath! == . EndLocal & goto EnterFilePathSub
set "NoSpaces=!FilePath: =!"
if .!NoSpaces! == . EndLocal & goto EnterFilePathSub
EndLocal
call :ValidatePath
if %ErrorLevel% neq 0 set Result=2 & goto ExitResult
:EnterAlias
set /p "Alias=Enter Alias. Leave blank to use the file name [Ctrl+C to exit]: "
goto DoWork


:BeginScript
set FilePath=%1
SetLocal EnableDelayedExpansion
if .!FilePath! == . EndLocal & goto EnterFilePath
if !FilePath! == /? EndLocal & call :Usage & goto Exit
set Arg3=%3
if not .!Arg3! == . EndLocal & call :Usage & goto Exit
EndLocal
set "FilePath=%~f1"
set FileDir=%~dp1
set Alias=%~n2
call :ValidatePath
if %ErrorLevel% neq 0 set Result=2 & goto ExitResult


:DoWork
call :GetAlias
call :UpdateRegistry
if %ErrorLevel% equ 0 set Result=0
goto ExitResult


:ValidatePath
for /f "tokens=*" %%a in ("%FilePath%") do (
    set FilePath=%%~fa
    set FileDir=%%~dpa
    set FileName=%%~na
)

call "%~dp0FileExists.bat" "%FilePath%"
if %ErrorLevel% neq 0 exit /b 1

:: Remove trailing slash
if %FileDir:~-1%==\ set FileDir=%FileDir:~0,-1%
exit /b 0


:GetAlias
SetLocal EnableDelayedExpansion
if .!Alias! == . (
    EndLocal
    set Alias=%FileName%
) else (
    set NoSpaces=!Alias: =!
    if .!NoSpaces! == . (
        EndLocal
        set Alias=%FileName%
    )
)
exit /b


:UpdateRegistry
set RegKey=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\%Alias%.exe

reg add "%RegKey%" /f /ve /d "%FilePath%" >nul
if %ErrorLevel% neq 0 exit /b 1

reg add "%RegKey%" /f /v "Path" /d "%FileDir%" >nul
if %ErrorLevel% neq 0 exit /b 1
exit /b 0


:PrintHeader
echo.
echo Allows a program/file to be opened from the "Run" dialog window using an alias.
echo.
exit /b


:Usage
call :PrintHeader
echo.%~n0 [Path [Alias]]
echo.
echo.  Path   Path to the program/file that will be run/opened.
echo.  Alias  Name that will be entered into the Run dialog window.
echo.         If excluded, defaults to the file's name.
echo.
echo.Examples:
echo.
echo.  C:\^>%~n0
echo.    Prompts for the file path and alias.
echo.
echo.  C:\^>%~n0 "C:\Program Files (x86)\NotePad++\notepad++.exe"
echo.    Runs Notepad++ when "notepad++" or "notepad++.exe" is entered.
echo.
echo.  C:\^>%~n0 "C:\Program Files (x86)\NotePad++\notepad++.exe" npp
echo.    Runs Notepad++ when "npp" or "npp.exe" is entered.
exit /b


:ExitResult
if %Result% equ 0 (
    echo Alias added: "%Alias%" -^> "%FilePath%"
) else (
    if %Result% equ 1 (
        (echo %~n0: Failed to add alias "%Alias%" -^> "%FilePath%")1>&2
    ) else (
        (echo %~n0: File does not exist: %FilePath%)1>&2
    )
)


:Exit
call "%~dp0PauseGui.bat" "%~f0"
@%ComSpec% /c exit !Result! >nul
