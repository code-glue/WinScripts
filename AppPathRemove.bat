@echo off

:: %License%


SetLocal DisableDelayedExpansion

set Result=1
goto BeginScript


:EnterAlias
call :PrintHeader
:EnterAliasSub
set /p "Alias=Enter alias name to remove [Ctrl+C to exit]: "
SetLocal EnableDelayedExpansion
if .!Alias! == . EndLocal & goto EnterAliasSub
set "NoSpaces=!Alias: =!"
if .!NoSpaces! == . EndLocal & goto EnterAliasSub
EndLocal
goto DoWork


:BeginScript
set Arg1=%1
set "Arg1NoQuotes=%Arg1:"=%"
set Arg2=%2

SetLocal EnableDelayedExpansion
if .!Arg1! == . EndLocal & goto EnterAlias
if !Arg1NoQuotes! == /? EndLocal & call :Usage & goto Exit
if not .!Arg2! == . EndLocal & call :Usage & goto Exit
EndLocal
set "Alias=%~1"


:DoWork
call :GetAlias "%Alias%"
call :Validate
if %ErrorLevel% neq 0 set Result=2 & goto ExitResult
call :UpdateRegistry
if %ErrorLevel% equ 0 set Result=0
goto ExitResult


:GetAlias
set Extension=%~x1
SetLocal EnableDelayedExpansion
if .!Extension! == . EndLocal & (set Alias=%~n1.exe)& exit /b
EndLocal
exit /b


:Validate
set RegKey=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\%Alias%
call "%~dp0RegKeyExists.bat" "%RegKey%"
exit /b %ErrorLevel%


:UpdateRegistry
reg delete "%RegKey%" /f >nul
exit /b %ErrorLevel%


:PrintHeader
echo.
echo Prevents a program/file from being opened from the "Run" dialog window using its alias.
echo.
exit /b


:Usage
call :PrintHeader
echo.%~n0 [Alias[.exe]]
echo.
echo.  Alias    The name of the alias to remove, optionally followed by ".exe".
echo.
echo.Examples:
echo.
echo.  C:\^>%~n0
echo.    Prompts for the alias.
echo.
echo.  C:\^>%~n0 "npp"
echo.    Removes the "npp.exe" alias from the registry.
echo.
echo.  C:\^>%~n0 "npp.exe"
echo.    Removes the "npp.exe" alias from the registry.
exit /b


:ExitResult
if %Result% equ 0 (
    echo Alias removed: "%Alias%"
) else (
    if %Result% equ 1 (
        (echo %~n0: Failed to remove alias "%Alias%")1>&2
    ) else (
        (echo %~n0: Alias not found: "%Alias%")1>&2
    )
)


:Exit
call "%~dp0PauseGui.bat" "%~f0"
@%ComSpec% /c exit !Result! >nul
