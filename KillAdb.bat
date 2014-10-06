@echo off

:: %License%

SetLocal DisableDelayedExpansion

set Result=1

SetLocal EnableDelayedExpansion
set Arg1=%1
if not .!Arg1! == . EndLocal & call :Usage & goto Exit
EndLocal


:DoWork
taskkill /im adb.exe /f 2>nul
set Result=%ErrorLevel%

:: ErrorLevel 128 means the process was not found, which in our case is a success.
:: However, for other errors, we need to display the error message,
:: so call taskkill again without redirecting the error.
if not %Result% equ 0 (
    if not %Result% equ 128 (
        taskkill /im adb.exe /f
    )
)
goto ExitResult


:Usage
echo.
echo Kills all instances of adb.exe.
echo.
echo.%~n0 ^<No Parameters^>
exit /b


:ExitResult
if %Result% equ 128 (
    set Result=0
    echo The process "adb.exe" was not running.
)


:Exit
call "%~dp0PauseGui.bat" "%~f0"
@%ComSpec% /c exit %Result% >nul
