@echo off

:: %License%

SetLocal DisableDelayedExpansion

set Result=1
set RegKey=HKCR\SystemFileAssociations\text\shell\open\command
set Count=0

if not [%1] == [] call :Usage & goto Exit

for /f "delims=  " %%a in ('reg query "%RegKey%" /ve') do (
    for %%b in (%%a) do (
        SetLocal EnableDelayedExpansion
        if !Count! equ 3 EndLocal & set TextEditor=%%~b && goto Expand
        EndLocal
        set /a Count+=1
    )
)

:Expand
for /f "delims=" %%a in ('echo "%TextEditor%"') do set TextEditor=%%~a
if not "%TextEditor%" == "" set Result=0
goto ExitResult


:Usage
echo.
echo Gets the default editor for text files.
echo.
echo.%~n0 ^<No Parameters^>
exit /b


:ExitResult
if %Result% equ 0 (
    echo %TextEditor%
) else (
    (echo %~n0: Failed to find text editor.)1>&2
)


:Exit
call "%~dp0PauseGui.bat" "%~f0"
@%ComSpec% /c exit %Result% >nul
