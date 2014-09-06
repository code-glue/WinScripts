@echo off

:: %License%

SetLocal

set FileName=%~n0
set Result=1

if [%1] == [] goto Exit
if "%~1" == "/?" goto Usage
if not [%2] == [] goto Usage

goto TestPath

:Usage
echo.
echo Determines whether the given path refers to an existing registry key.
echo Sets the ErrorLevel variable to 0 if the registry key exists; otherwise, 1.
echo.
echo.%FileName% KeyName
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
echo.  C:\^>%FileName%
echo.    Sets %%ErrorLevel%% to 1
echo.
echo.  C:\^>%FileName% "HKCR"
echo.    Sets %%ErrorLevel%% to 0. Registry key exists.
echo.
echo.  C:\^>%FileName% "HKCU\BadKeyName"
echo.    Sets %%ErrorLevel%% to 1. Registry key does not exist.
goto Exit


:TestPath
reg query "%~1" >nul 2>&1
if %ErrorLevel% equ 0 set Result=0


:Exit
@%ComSpec% /c exit %Result% >nul
