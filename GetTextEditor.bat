@echo off

:: %License%

SetLocal EnableDelayedExpansion

set Result=1
set FileName=%~n0
set PauseOnError=%~dp0PauseOnError.bat
set RegKey=HKCR\SystemFileAssociations\text\shell\open\command
set Count=0

if not [%1] == [] goto Usage

for /f "delims=  " %%a in ('reg query "!RegKey!" /ve') do (
    for %%b in (%%a) do (
        if !Count! equ 3 set TextEditor=%%~b && goto Expand
        set /a Count+=1
    )
)

:Expand
for /f "delims=" %%a in ('echo "%TextEditor%"') do set TextEditor=%%~a
if not "%TextEditor%" == "" set Result=0 & echo %TextEditor%
goto ExitResult


:Usage
echo.
echo Gets the default editor for text files.
echo.
echo.%FileName% ^<No Parameters^>
goto Exit


:ExitResult
if %Result% neq 0 echo %FileName%: Failed to find text editor. 1>&2 & call "%PauseOnError%"


:Exit
@%ComSpec% /c exit %Result% >nul
