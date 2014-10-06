@echo off

:: %License%

SetLocal DisableDelayedExpansion

set Result=1

if not [%1] == [] call :Usage & goto Exit

set IconCachePath=%LocalAppData%\IconCache.db
if exist "%IconCachePath%" del "%IconCachePath%" /a
if not exist "%IconCachePath%" set Result=0
REM ie4uinit.exe -ClearIconCache
REM if %ErrorLevel% equ 0 set Result=0
goto ExitResult


:Usage
echo Clears the icon cache
echo.
echo.%~n0 ^<No Parameters^>
exit /b

:ExitResult
if %Result% equ 0 (
    echo Deleted file: "%IconCachePath%"
) else (
    (echo %~n0: Failed to delete file: "%IconCachePath%")1>&2
)

:Exit
call "%~dp0PauseGui.bat" "%~f0"
@%ComSpec% /c exit %Result% >nul
