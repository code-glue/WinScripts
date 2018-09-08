@echo off

:: %License%

SetLocal DisableDelayedExpansion

set Result=1
goto BeginScript


:EnterExtension
call :PrintHeader
:EnterExtensionSub
set /p "Extension=Enter file extension [Ctrl+C to exit]: "
SetLocal EnableDelayedExpansion
if .!Extension! == . EndLocal & goto EnterExtensionSub
set "NoSpaces=!Extension: =!"
if .!NoSpaces! == . EndLocal & goto EnterExtensionSub
EndLocal
goto DoWork


:BeginScript
set Arg1=%1
set "Arg1NoQuotes=%Arg1:"=%"
set Arg2=%2

SetLocal EnableDelayedExpansion
if .!Arg1! == . EndLocal & goto EnterExtension
if !Arg1NoQuotes! == /? EndLocal & call :Usage & goto Exit
if not .!Arg2! == . EndLocal & call :Usage & goto Exit
EndLocal
set "Extension=%~1"


:DoWork
call :Validate
if %ErrorLevel% neq 0 set Result=2 & goto ExitResult
call :CleanExtension
if %ErrorLevel% neq 0 set Result=2 & goto ExitResult
call :UpdateRegistry
if %ErrorLevel% equ 0 set Result=0
goto ExitResult


:Validate
SetLocal EnableDelayedExpansion
set NoSymbols=!Extension!
set "NoSpaces=!NoSymbols: =!"
if .!NoSpaces! == . exit /b 1

set "NoSymbols=!NoSymbols:/=!"
set "NoSymbols=!NoSymbols:\=!"
set "NoSymbols=!NoSymbols::=!"
set "NoSymbols=!NoSymbols:?=!"
set "NoSymbols=!NoSymbols:<=!"
set "NoSymbols=!NoSymbols:>=!"
set "NoSymbols=!NoSymbols:|=!"
set "NoSymbols=!NoSymbols:"=!"
set "NoSymbols=!NoSymbols:**=!"
set "NoSymbols=!NoSymbols:"=!"

if not !Extension! == !NoSymbols! exit /b 1
exit /b 0


:CleanExtension
if not "%Extension%" == "." (
    for /f "tokens=*" %%a in (".%Extension%") do (
        SetLocal EnableDelayedExpansion
        set Ext=%%~xa
        if .!Ext! == . exit /b 1
        EndLocal
        set Extension=%%~xa
    )
)
exit /b 0


:UpdateRegistry
reg add "HKCR\%Extension%\PersistentHandler" /ve /d "{098F2470-BAE0-11CD-B579-08002B30BFEB}" /f > nul
if %ErrorLevel% neq 0 exit /b 1
exit /b 0


:PrintHeader
echo.
echo Adds a NULL filter to the given file extension, telling the search indexer to ignore the file's contents.
echo.
exit /b 0


:Usage
call :PrintHeader
echo.%~n0 [[.]Extension]
echo.
echo.  Extension    The name of the extension to add, optionally prefixed by ".".
echo.               Omit to prompt for the extension.
echo.
echo.Examples:
echo.
echo.  C:\^>%~n0
echo.    Prompts for the file extension.
echo.
echo.  C:\^>%~n0 "exe"
echo.    Adds a NULL handler for the .exe file extension.
echo.
echo.  C:\^>%~n0 ".bin"
echo.    Adds a NULL handler for the .bin file extension.
exit /b


:ExitResult
SetLocal EnableDelayedExpansion
if !Result! equ 0 (
    echo Added NULL persistent handler for file extension: !Extension!
) else (
    if !Result! equ 1 (
        (echo %~n0: Failed to update extension: !Extension!)1>&2
    ) else (
        (echo %~n0: Invalid extension: !Extension!)1>&2
    )
)
EndLocal



:Exit
call "%~dp0PauseGui.bat" "%~f0"
@%ComSpec% /c exit %Result% >nul
