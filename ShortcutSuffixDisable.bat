@echo off

:: %License%


SetLocal DisableDelayedExpansion

set Result=1
set RestartExplorer=%~dp0RestartExplorer.bat
set Restart=0
set UI=0


:InitArgs
SetLocal EnableDelayedExpansion
set Arg1=%1
set Arg2=%2
if !Arg1! == /? call :Usage & goto Exit
if not .!Arg2! == . call :Usage & goto Exit
if .!Arg1! == . EndLocal & (set UI=1) & goto BeginScript
EndLocal
if /i "%~1" == "/y" set Restart=1 & goto BeginScript
if /i not "%~1" == "/n" call :Usage & goto Exit


:BeginScript
call :UpdateRegistry
set Result=%ErrorLevel%
call :UpdateRegistryResult
if %Result% equ 0 (
    call :RestartExplorer
    if %ErrorLevel% neq 0 set Result=1
)
goto Exit


:UpdateRegistry
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /t REG_BINARY /d 00000000 /f >nul
exit /b %ErrorLevel%


:RestartExplorer
if %UI% equ 1 (
    echo.
    call "%RestartExplorer%"
    exit /b %ErrorLevel%
)

if %Restart% equ 0 exit /b %ErrorLevel%
call "%RestartExplorer%" /q
exit /b %ErrorLevel%


:Usage
echo Disables the setting to append " - Shortcut" on new shortcuts.
echo Requires explorer.exe to be restarted.
echo.
echo.%~n0 [/Y ^| /N]
echo.
echo.  /Y    Restart explorer.exe.
echo.  /N    Do not restart explorer.exe.
echo.
echo.Examples:
echo.
echo.  C:\^>%~n0
echo.    Disables the setting to append " - Shortcut" on new shortcuts,
echo.    and prompts to restart explorer.exe.
echo.
echo.  C:\^>%~n0 /y
echo.    Disables the setting to append " - Shortcut" on new shortcuts,
echo.    and restarts explorer.exe without prompting.
echo.
echo.  C:\^>%~n0 /n
echo.    Disables the setting to append " - Shortcut" on new shortcuts,
echo.    and does not restart explorer.exe.
exit /b


:UpdateRegistryResult
if %Result% equ 0 (
    echo Shortcut suffix disabled.
) else (
   (echo %~n0: Failed to disable shortcut suffix.)1>&2
)
exit /b


:Exit
call "%~dp0PauseGui.bat" "%~f0"
@%ComSpec% /c exit %Result% >nul
