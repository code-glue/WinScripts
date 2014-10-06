@echo off

:: %License%

SetLocal DisableDelayedExpansion

set Arg1=%1
set "Arg1NoQuotes=%Arg1:"=%"
set Arg2=%2

SetLocal EnableDelayedExpansion
if !Arg1NoQuotes! == /? EndLocal & call :Usage & goto Exit
if not .!Arg2! == . EndLocal &  call :Usage & goto Exit
if !DisablePauseGui! equ 1 EndLocal & goto Exit
EndLocal


if "%~1" == "" ((echo.%CmdCmdLine%)|"%WinDir%\System32\find.exe" /I "%~0")>nul && (echo. & pause) & exit /b 0
((echo.%CmdCmdLine%)|"%WinDir%\System32\find.exe" /I "%~1")>nul && (echo. & pause)
exit /b 0


:Usage
echo.
echo Suspends processing of a batch program if run from explorer.exe; otherwise, does nothing.
echo To prevent pausing, set DisablePauseGui=1
echo.
echo.%~n0 [PathToCallingScript]
echo.
echo.  PathToCallingScript    The full path to the calling script.
echo.                         If omitted, the path to this script is used.
echo.
echo.Examples:
echo.  Given the file AnyOtherFile.bat:
echo.     @echo off
echo.     call %~n0 "%%~f0"
echo.
echo.  C:\^>AnyOtherFile.bat
echo.     No operation is performed.
echo.
echo.  If AnyOtherFile.bat is opened from explorer.exe:
echo.     Press any key to continue . . .
exit /b


:Exit
@%ComSpec% /c exit %ErrorLevel% >nul
