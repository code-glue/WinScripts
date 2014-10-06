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
set "RegPath=%~1"
set "RegPath=%RegPath:"=\"%"
SetLocal EnableDelayedExpansion
reg query "!RegPath!" >nul 2>&1
if %ErrorLevel% equ 0 EndLocal & (set Result=0) & goto Exit
EndLocal
goto Exit


:Usage
echo.
echo Determines whether the given path refers to an existing registry key.
echo Sets the ErrorLevel variable to 0 if the registry key exists; otherwise, 1.
echo.
echo.%~n0 KeyName
echo.
echo.  KeyName  [\\Machine\]FullKey
echo.           Machine - Name of remote machine, omitting defaults to the
echo.                     current machine. Only HKLM and HKU are available on
echo.                     remote machines
echo.           FullKey - in the form of ROOTKEY\SubKey name
echo.                ROOTKEY - [ HKLM ^| HKCU ^| HKCR ^| HKU ^| HKCC ]
echo.                SubKey  - The full name of a registry key under the
echo.                          selected ROOTKEY
echo.
echo.Examples:
echo.
echo.  C:\^>%~n0
echo.    Sets %%ErrorLevel%% to 1.
echo.
echo.  C:\^>%~n0 "HKCR"
echo.    Sets %%ErrorLevel%% to 0. Registry key exists.
echo.
echo.  C:\^>%~n0 "HKCU\BadKeyName"
echo.    Sets %%ErrorLevel%% to 1. Registry key does not exist.
exit /b


:Exit
@%ComSpec% /c exit %Result% >nul
