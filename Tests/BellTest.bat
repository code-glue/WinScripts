@echo off

SetLocal DisableDelayedExpansion

set BatchFile=%~dp0..\Bell.bat
pushd "%~dp0"

set Desc=ErrorLevel doesn't change when 1
verify ? 2>nul
if %ErrorLevel% neq 1 goto ExitFail
call "%BatchFile%"
if %ErrorLevel% neq 1 goto ExitFail

set Desc=ErrorLevel doesn't change when 0
verify>nul
if %ErrorLevel% neq 0 goto ExitFail
call "%BatchFile%"
if %ErrorLevel% neq 0 goto ExitFail

set Desc=ErrorLevel should be 1 for usage
verify>nul
call "%BatchFile%" "/?" >nul
if %ErrorLevel% neq 1 goto ExitFail

set Desc=Output should not go to stdout or stderr
call "%BatchFile%" >BeepTestOutput.txt
for /f "usebackq" %%a in ('BeepTestOutput.txt') do (set FileSize=%%~za)
if %FileSize% neq 0 goto ExitFail
del BeepTestOutput.txt >nul 2>&1

echo.
echo All tests passed
goto Exit


:ExitFail
echo.
SetLocal EnableDelayedExpansion
echo Test failed: !Desc!
EndLocal


:Exit
popd
call "%~dp0..\PauseGui.bat" "%~f0"
