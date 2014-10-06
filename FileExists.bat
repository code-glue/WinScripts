@echo off

:: %License%

SetLocal DisableDelayedExpansion

set Result=1
set Arg1=%1
set "Arg1NoQuotes=%Arg1:"=%"
set Arg2=%2

SetLocal EnableDelayedExpansion
if .!Arg1! == . EndLocal & goto Exit
if !Arg1NoQuotes! == /? EndLocal & call :Usage & goto Exit
if not .!Arg2! == . EndLocal & call :Usage & goto Exit
EndLocal


:TestPath
set "FilePath=%~f1"
if "%FilePath:~-1%" == "." set Result=1 & goto Exit
if exist "%FilePath%" (2>nul pushd "%FilePath%" && (popd) || set Result=0)
goto Exit


:Usage
echo.
echo Determines whether the given path refers to an existing file.
echo Sets the ErrorLevel variable to 0 if the file exists; otherwise, 1.
echo.
echo.%~n0 Path
echo.
echo.  Path    The path to test.
echo.
echo.Examples:
echo.
echo.  C:\^>%~n0
echo.    Sets %%ErrorLevel%% to 1.
echo.
echo.  C:\^>%~n0 "C:\Windows\notepad.exe"
echo.    Sets %%ErrorLevel%% to 0. File exists.
echo.
echo.  C:\^>%~n0 "C:\Windows"
echo.    Sets %%ErrorLevel%% to 1. Path exists but is a directory.
exit /b


:Exit
@%ComSpec% /c exit %Result% >nul
