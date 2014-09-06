@echo off

:: %License%

SetLocal

set FileName=%~n0
set Result=1

if "%~1" == "/?" goto Usage
if not [%2] == [] goto Usage

goto TestPath

:Usage
echo.
echo Determines whether the given path refers to an existing file.
echo Sets the ErrorLevel variable to 0 if the file exists; otherwise, 1.
echo.
echo.%FileName% Path
echo.
echo.  Path    The path to test.
echo.
echo.Examples:
echo.
echo.  C:\^>%FileName%
echo.    Sets %%ErrorLevel%% to 1
echo.
echo.  C:\^>%FileName% "C:\Windows\notepad.exe"
echo.    Sets %%ErrorLevel%% to 0. File exists.
echo.
echo.  C:\^>%FileName% "C:\Windows"
echo.    Sets %%ErrorLevel%% to 1. Path exists but is a directory.
goto Exit


:TestPath
if exist "%~f1" (2>nul pushd "%~f1" && (popd) || set Result=0)


:Exit
@%ComSpec% /c exit %Result% >nul
