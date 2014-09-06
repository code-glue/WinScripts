@echo off

:: %License%

SetLocal

set Result=1
if exist "%~f1" (2>nul pushd "%~f1" && (popd) || set Result=0)

REM echo Result=%Result%
@%COMSPEC% /C exit %Result% >nul
