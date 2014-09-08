@echo off

:: %License%

SetLocal

set Result=1
set FileName=%~n0
set PauseOnError=%~dp0PauseOnError.bat

if not [%1] == [] goto Usage

set IconCachePath=%LocalAppData%\IconCache.db
if exist "%IconCachePath%" del "%IconCachePath%" /a
if not exist "%IconCachePath%" set Result=0
REM ie4uinit.exe -ClearIconCache

if %ErrorLevel% equ 0 set Result=0
goto ExitResult


:Usage
echo Clears the icon cache
echo.
echo.%FileName% ^<No Parameters^>
goto Exit


:ExitResult
if %Result% neq 0 call "%PauseOnError%"


:Exit
@%ComSpec% /c exit %Result% >nul
