@echo off
echo.
echo Removes programs from being accessed via the Start-^>Run dialog window.

set ExePath=%~f1

if "%ExePath%" == "" (
    goto ui
)

set ExeName=%~nx1
set RegKey=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\%ExeName%

reg query "%RegKey%" >NUL 2>&1
if not %ErrorLevel% == 0 (
    echo.
    echo Invalid key name: "%RegKey%"
    exit /b
)

goto regdelete

:invalidpathui
echo.
echo Invalid key name: "%RegKey%"

:ui
echo.
set /p ExePath=Enter exe file name [Ctrl+C to exit]: 
if errorlevel 1 set "ExePath=" & verify>nul
if "%ExePath%" == "" (
    goto ui
)

for %%i in ("%ExePath%") do (
    set ExePath=%%~fi
    set ExeName=%%~nxi
)

set RegKey=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\%ExeName%

REM echo ExePath = '%ExePath%'
REM echo ExeName = '%ExeName%'
REM echo RegKey  = '%RegKey%'

reg query "%RegKey%" >NUL 2>&1
if %ErrorLevel% == 0 (
    goto regdelete
)

goto invalidpathui

:regdelete
REM echo ExePath = '%ExePath%'
REM echo ExeName = '%ExeName%'
REM echo RegKey  = '%RegKey%'

reg delete "%RegKey%" /f
exit /b

echo.
echo Registry key not found: "%RegKey%"
