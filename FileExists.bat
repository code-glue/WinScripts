@echo off

:: %License%

SetLocal

set Result=1

if [%1] == [] goto Exit
if "%~1" == "/?" call :Usage & goto Exit
if not [%2] == [] call :Usage & goto Exit

goto TestPath

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


:TestPath
if exist "%~f1" (2>nul pushd "%~f1" && (popd) || set Result=0)


:Exit
@%ComSpec% /c exit %Result% >nul
