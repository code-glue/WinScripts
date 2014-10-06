@echo off

:: %License%

SetLocal DisableDelayedExpansion

set Result=1
goto BeginScript


:EnterExePath
call :PrintHeader
:EnterExePathSub
set /p "ExePath=Enter .exe file path for text editor [Ctrl+C to exit]: "
SetLocal EnableDelayedExpansion
if .!ExePath! == . EndLocal & goto EnterExePathSub
set "NoSpaces=!ExePath: =!"
if .!NoSpaces! == . EndLocal & goto EnterExePathSub
set "NoSpaces=!ExePath:"=!"
if .!NoSpaces! == . EndLocal & goto EnterExePathSub
EndLocal
set ExePath=%ExePath:"=%
goto DoWork


:BeginScript
set ExePath=%1
SetLocal EnableDelayedExpansion
if .!ExePath! == . EndLocal & goto EnterExePath
if !ExePath! == /? EndLocal & call :Usage & goto Exit
set Arg2=%2
if not .!Arg2! == . EndLocal & call :Usage & goto Exit
EndLocal
set "ExePath=%~1"


:DoWork
call :Validate
if %ErrorLevel% neq 0 set Result=2 & goto ExitResult
call :UpdateRegistry
if %ErrorLevel% equ 0 set Result=0
goto ExitResult


:Validate
for /f "tokens=*" %%a in ("%FilePath%") do set ExePath=%%~fa
call "%~dp0FileExists.bat" "%ExePath%"
if %ErrorLevel% neq 0 exit /b 1
exit /b 0


:UpdateRegistry
set TextShellPath=HKCR\SystemFileAssociations\text
set AppPath=HKCR\Applications\%ExeName%\shell
set Command=\"%ExePath%\" \"%%1\"

reg add "%TextShellPath%\shell\open\command" /ve /d "\"%ExePath%\" \"%%1\"" /f >nul
if %ErrorLevel% neq 0 exit /b 1

reg add "%TextShellPath%\shell\edit\command" /ve /d "\"%ExePath%\" \"%%1\"" /f >nul
if %ErrorLevel% neq 0 exit /b 1

reg add "%TextShellPath%\OpenWithList\%ExeName%" /ve /f >nul
if %ErrorLevel% neq 0 exit /b 1

reg add "%AppPath%\open\command" /ve /d "%Command%" /f >nul
if %ErrorLevel% neq 0 exit /b 1

reg add "%AppPath%\edit\command" /ve /d "%Command%" /f >nul
if %ErrorLevel% neq 0 exit /b 1
exit /b 0


:PrintHeader
echo.
echo Sets the default editor for text files.
echo.
exit /b


:Usage
call :PrintHeader
echo.%~n0 ExePath
echo.
echo.  ExePath    The path of the program to set as the default text editor.
echo.
echo.Examples:
echo.
echo.  C:\^>%~n0
echo.    Prompts for the path.
echo.
echo.  C:\^>%~n0 "C:\Program Files (x86)\Notepad++\notepad++.exe"
echo.    Sets Notepad++ as the default text editor.
exit /b


:ExitResult
if %Result% equ 0 (
    echo Default text editor set to: "%ExePath%"
) else (
    if %Result% equ 1 (
        (echo %~n0: Failed to set text editor: "%ExePath%")1>&2
    ) else (
        (echo %~n0: Invalid path: "%ExePath%")1>&2
    )
)


:Exit
call "%~dp0PauseGui.bat" "%~f0"
@%ComSpec% /c exit %Result% >nul
