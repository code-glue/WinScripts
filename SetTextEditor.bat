@echo off

:: %License%


SetLocal EnableDelayedExpansion

set Result=1
set ExePath=%~1
set ExeName=%~nx1
set ScriptName=%~n0
set PauseOnError=%~dp0PauseOnError.bat
set FileExists=%~dp0FileExists.bat

if [%1] == [] goto UI
if "%~1" == "/?" goto Usage
if not [%2] == [] goto Usage

goto VerifyPath


:UI
call :PrintHeader
echo.


:EnterPath
set /p ExePath="Enter .exe file path for text editor [Ctrl^+C to exit]: " %=%
if %ErrorLevel% neq 0 set "ExePath=" & verify >nul & goto EnterPath

:: Remove quotes
set ExePath=%ExePath:"=%

if "%ExePath%" == "" goto :EnterAlias
if "%ExePath%" == "." goto EnterAlias
if "%ExePath%" == ".." goto EnterAlias


:VerifyPath
:: Expand path
for %%a in ("!ExePath!") do (
    set ExePath=%%~fa
    set ExeName=%%~nxa
)

call "%FileExists%" "!ExePath!"
if %ErrorLevel% neq 0 goto InvalidPath


:RegAdd
set TextShellPath=HKCR\SystemFileAssociations\text
set AppPath=HKCR\Applications\%ExeName%\shell
set Command=\"%ExePath%\" \"%%1\"

reg add "%TextShellPath%\shell\open\command" /ve /d "\"%ExePath%\" \"%%1\"" /f >nul
if %ErrorLevel% equ 0 set Result=0

reg add "%TextShellPath%\shell\edit\command" /ve /d "\"%ExePath%\" \"%%1\"" /f >nul
if %ErrorLevel% neq 0 set Result=1

reg add "%TextShellPath%\OpenWithList\%ExeName%" /ve /f >nul
if %ErrorLevel% neq 0 set Result=1

reg add "%AppPath%\open\command" /ve /d "%Command%" /f >nul
if %ErrorLevel% neq 0 set Result=1

reg add "%AppPath%\edit\command" /ve /d "%Command%" /f >nul
if %ErrorLevel% neq 0 set Result=1

goto ExitResult


:PrintHeader
echo.
echo Sets the default editor for text files.
exit /b 0


:Usage
call :PrintHeader
echo.
echo.%ScriptName% [ExePath]
echo.
echo.  ExePath    The path of the program to set as the default text editor.
echo.
echo.Examples:
echo.
echo.  C:\^>%ScriptName%
echo.    Prompts for the path.
echo.
echo.  C:\^>%ScriptName% "C:\Program Files (x86)\Notepad++\notepad++.exe"
echo.    Sets Notepad++ as the default text editor.
goto Exit


:InvalidPath
echo File does not exist: "%ExePath%" 1>&2


:ExitResult
if !Result! neq 0 call "%PauseOnError%"


:Exit
@%ComSpec% /c exit !Result! >nul
