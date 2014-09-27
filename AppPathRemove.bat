@echo off

:: %License%

SetLocal EnableDelayedExpansion

set Result=1
set ScriptName=%~n0
set Alias=%~1
set PauseOnError=%~dp0PauseOnError.bat
set RegKeyExists=%~dp0RegKeyExists.bat

if [%1] == [] goto UI
if "%~1" == "/?" goto Usage
if not [%2] == [] goto Usage

goto VerifyKey


:GetAlias
set Extension=%~x1
if "%~x1" == "" set Extension=.exe
set Alias=%~n1!Extension!
exit /b 0


:UI
call :PrintHeader


:EnterAlias
set /p Alias="Enter alias name to remove [Ctrl+C to exit]: " %=%
if %ErrorLevel% neq 0 set "Alias=" & verify >nul & goto EnterAlias

if "%Alias%" == "" goto EnterAlias
if "%Alias%" == "." goto EnterAlias
if "%Alias%" == ".." goto EnterAlias


:VerifyKey
call :GetAlias "%Alias%"
set RegKey=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\%Alias%
call "%RegKeyExists%" "%RegKey%"
if %ErrorLevel% neq 0 goto ExitResult


:RegDelete
reg delete "%RegKey%" /f >nul
if %ErrorLevel% neq 0 goto ExitResult
set Result=0
goto ExitResult


:PrintHeader
echo.
echo Prevents a program/file from being opened from the "Run" dialog window using its alias.
echo.
exit /b 0


:Usage
call :PrintHeader
echo.%ScriptName% [Alias[.exe]]
echo.
echo.  Alias    The name of the alias to remove, optionally followed by ".exe".
echo.
echo.Examples:
echo.
echo.  C:\^>%ScriptName%
echo.    Prompts for the alias.
echo.
echo.  C:\^>%ScriptName% "npp"
echo.    Removes the "npp.exe" alias from the registry.
echo.
echo.  C:\^>%ScriptName% "npp.exe"
echo.    Removes the "npp.exe" alias from the registry.
goto Exit


:ExitResult
if !Result! neq 0 (
    echo.
    echo %ScriptName%: Alias not found: "%Alias%" 1>&2
    echo.
    call "%PauseOnError%"
)


:Exit
@%ComSpec% /c exit !Result! >nul
