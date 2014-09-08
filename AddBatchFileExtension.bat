@echo off

:: %License%

SetLocal EnableDelayedExpansion

set Result=1
set PauseOnError=%~dp0PauseOnError.bat
set FileName=%~n0
set Extension=%~1

if [%1] == [] goto UI
if "%~1" == "/?" goto Usage
if not [%2] == [] goto Usage

goto GetExtension


:UI
call :PrintHeader


:EnterExtension
set /p Extension="Enter file extension [Ctrl+C to exit]: " %=%
if %ErrorLevel% neq 0 set "Extension=" & verify >nul & goto EnterExtension

if "%Extension%" == "" goto EnterExtension
if "%Extension%" == "." goto EnterExtension
if "%Extension%" == ".." goto EnterExtension


:GetExtension
set Extension=.!Extension!
for %%a in ("!Extension!") do (
    call set Extension=%%~xa
)

reg add "HKCR\!Extension!" /ve /d "batfile" /f >nul
if !ErrorLevel! equ 0 set Result=0

goto ExitResult

:PrintHeader
echo.
echo Makes the specified file extension behave like a batch file (i.e. .bat, .cmd. etc).
echo.
exit /b 0


:Usage
call :PrintHeader
echo.%FileName% [.]Extension
echo.
echo.  Extension    The name of the extension, optionally prefixed by ".".
echo.
echo.Examples:
echo.
echo.  C:\^>%FileName%
echo.    Prompts for the file extension.
echo.
echo.  C:\^>%FileName% "sh"
echo.    Makes files with the .sh file extension behave like a batch file.
echo.
echo.  C:\^>%FileName% ".sh"
echo.    Makes files with the .sh file extension behave like a batch file.
goto Exit


:ExitResult
if %Result% neq 0 call "%PauseOnError%"


:Exit
@%ComSpec% /c exit %Result% >nul
