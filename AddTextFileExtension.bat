@echo off

:: %License%

SetLocal DisableDelayedExpansion

set Result=1
goto BeginScript


:EnterExtension
call :PrintHeader
:EnterExtensionSub
set /p "Extension=Enter file extension [Ctrl+C to exit]:"
SetLocal EnableDelayedExpansion
if .!Extension! == . EndLocal & goto EnterExtensionSub
set "NoSpaces=!Extension: =!"
if .!NoSpaces! == . EndLocal & goto EnterExtensionSub
EndLocal
call :Validate
if %ErrorLevel% neq 0 set Result=2 & goto ExitResult
goto DoWork


:BeginScript
set Extension=%1
SetLocal EnableDelayedExpansion
if .!Extension! == . EndLocal & goto EnterExtension
if !Extension! == /? EndLocal & call :Usage & goto Exit
set Arg2=%2
if not .!Arg2! == . EndLocal & call :Usage & goto Exit
EndLocal
set "Extension=%~1"


:DoWork
SetLocal EnableDelayedExpansion
EndLocal
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
reg add "HKCR\%Extension%" /v "PerceivedType" /d "text" /f >nul
if %ErrorLevel% neq 0 exit /b 1
reg add "HKCR\%Extension%\PersistentHandler" /ve /d "{5E941D80-BF96-11CD-B579-08002B30BFEB}" /f > nul
if %ErrorLevel% neq 0 exit /b 1
exit /b 0


:PrintHeader
echo.
echo Adds a plain text handler to the given file extension, allowing files with the extension to be indexed, searched, and easily opened in any text editor.
echo.
exit /b 0


:Usage
call :PrintHeader
echo.%~n0 [[.]Extension]
echo.
echo.  Extension    The name of the extension to add, optionally prefixed by ".".
echo.               Use "." for files without an extension.
echo.               Omit to prompt for the extension.
echo.
echo.Examples:
echo.
echo.  C:\^>%~n0
echo.    Prompts for the file extension.
echo.
echo.  C:\^>%~n0 "txt"
echo.    Adds a plain text handler for the .txt file extension.
echo.
echo.  C:\^>%~n0 ".txt"
echo.    Adds a plain text handler for the .txt file extension.
echo.
echo.  C:\^>%~n0 .
echo.    Adds a plain text handler for files without an extension.
exit /b


:ExitResult
SetLocal EnableDelayedExpansion
if !Result! equ 0 (
    echo Added plain text persistent handler for file extension: !Extension!
) else (
    if !Result! equ 1 (
        echo Failed to update extension: !Extension!
    ) else (
        echo Invalid extension: !Extension!
    )
)
EndLocal



:Exit
call "%~dp0PauseIfGui.bat" "%~f0"
@%ComSpec% /c exit %Result% >nul
