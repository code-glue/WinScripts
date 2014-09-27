@echo off

:: %License%

SetLocal

set Result=1
set ScriptName=%~n0
set PauseOnError=%~dp0PauseOnError.bat
set RestartExplorer=%~dp0RestartExplorer.bat
set Restart=0
set UI=0

if [%1] == [] set UI=1 & goto RegAdd
if "%~1" == "/?" goto Usage
if not [%2] == [] goto Usage
if /i "%~1" == "/y" set Restart=1 & goto RegAdd
if /i not "%~1" == "/n" goto Usage


:RegAdd
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /t REG_BINARY /d 1e000000 /f >nul
if %ErrorLevel% equ 0 set Result=0

if %Result% neq 0 goto ExitResult
if %UI% equ 1 (
    call "%RestartExplorer%"
    set Result=%ErrorLevel%
    goto ExitResult
)

if %Restart% equ 0 goto ExitResult

call "%RestartExplorer%" /q
set Result=%ErrorLevel%
goto ExitResult


:Usage
echo Enables the setting to append " - Shortcut" on new shortcuts.
echo Requires explorer.exe to be restarted.
echo.
echo.%ScriptName% [/Y ^| /N]
echo.
echo.  /Y    Restart explorer.exe without prompting.
echo.  /N    Do not restart explorer.exe.
echo.
echo.Examples:
echo.
echo.  C:\^>%ScriptName%
echo.    Enables the setting to append " - Shortcut" on new shortcuts,
echo.    and prompts to restart explorer.exe.
echo.
echo.  C:\^>%ScriptName% /y
echo.    Enables the setting to append " - Shortcut" on new shortcuts,
echo.    and restarts explorer.exe without prompting.
echo.
echo.  C:\^>%ScriptName% /n
echo.    Enables the setting to append " - Shortcut" on new shortcuts,
echo.    and does not restart explorer.exe.
goto Exit


:ExitResult
if %Result% neq 0 call "%PauseOnError%"


:Exit
@%ComSpec% /c exit %Result% >nul
