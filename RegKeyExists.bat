@echo off

:: %License%

SetLocal DisableDelayedExpansion

set Result=1

if [%1] == [] goto Exit
if "%~1" == "/?" call :Usage & goto Exit
if not [%2] == [] call :Usage & goto Exit

goto TestPath

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


:TestPath
reg query "%~1" >nul 2>&1
if %ErrorLevel% equ 0 set Result=0


:Exit
@%ComSpec% /c exit %Result% >nul
