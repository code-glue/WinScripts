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
set "DirPath=%~f1"
if "%DirPath:~-1%" == "." set Result=1 & goto Exit
if exist "%DirPath%" (2>nul pushd "%DirPath%" && (popd & EndLocal & set Result=0))
goto Exit


:Usage
echo.
echo Determines whether the given path refers to an existing directory.
echo Sets the ErrorLevel variable to 0 if the directory exists; otherwise, 1.
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
echo.  C:\^>%~n0 "C:\Windows"
echo.    Sets %%ErrorLevel%% to 0. Directory exists.
echo.
echo.  C:\^>%~n0 "C:\"
echo.    Sets %%ErrorLevel%% to 0. Drives are considered directories.
echo.
echo.  C:\^>%~n0 "C:\Windows\notepad.exe"
echo.    Sets %%ErrorLevel%% to 1. Path exists but is a file.
exit /b


:Exit
@%ComSpec% /c exit %Result% >nul
