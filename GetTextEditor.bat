@echo off

:: %License%


SetLocal EnableDelayedExpansion

if not [%1] == [] goto Usage

set Here=%~dp0
set RegKey=HKCR\SystemFileAssociations\text\shell\open\command
set Count=0

for /f "delims=  " %%a in ('reg query "!RegKey!" /ve') do (
    for %%b in (%%a) do (
        if !Count! equ 3 set TextEditor=%%~b && goto Expand
        set /a Count+=1
    )
)

:Expand
for /f "delims=" %%a in ('echo "%TextEditor%"') do set TextEditor=%%~a

if "%TextEditor%" == "" (
    echo Failed to find text editor. 1>&2
    call "%Here%PauseOnError.bat"
    exit /b 1
)

echo %TextEditor%
exit /b 0

:Usage
echo.
echo Gets the default editor for text files.
exit /b 1
