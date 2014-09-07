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

reg add "HKCR\!Extension!" /v "PerceivedType" /d "text" /f >nul
if !ErrorLevel! equ 0 set Result=0

reg add "HKCR\!Extension!\PersistentHandler" /ve /d "{5E941D80-BF96-11CD-B579-08002B30BFEB}" /f > nul
if !ErrorLevel! neq 0 set Result=1

if !Result! equ 0 echo Added plain text persistent handler for file extension: !Extension!
goto ExitResult


:PrintHeader
echo.
echo Adds a plain text handler to the given file extension, allowing files with the extension to be indexed, searched, and easily opened in any text editor.
echo.
exit /b 0


:Usage
call :PrintHeader
echo.%FileName% [.]Extension
echo.
echo.  Extension    The name of the extension to add, optionally prefixed by ".".
echo.
echo.Examples:
echo.
echo.  C:\^>%FileName%
echo.    Prompts for the file extension
echo.
echo.  C:\^>%FileName% "txt"
echo.    Adds a plain text handler for the .txt file extension.
echo.
echo.  C:\^>%FileName% ".txt"
echo.    Adds a plain text handler for the .txt file extension.
goto Exit


:ExitResult
if %Result% neq 0 call "%PauseOnError%"


:Exit
@%ComSpec% /c exit %Result% >nul
