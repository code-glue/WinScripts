@echo off

SetLocal

set BatchFile=%~dp0..\RegKeyExists.bat

set Desc=[empty]
call "%BatchFile%"
if %ErrorLevel% neq 1 goto ExitFail

set Desc=HKCR
call "%BatchFile%" HKCR
if %ErrorLevel% neq 0 goto ExitFail

set Desc=HKCR\BadPath
call "%BatchFile%" HKCR\BadPath
if %ErrorLevel% neq 1 goto ExitFail

set Desc=HKCR\.txt
call "%BatchFile%" HKCR\.txt
if %ErrorLevel% neq 0 goto ExitFail


echo.
echo All tests passed
goto Exit


:ExitFail
echo.
echo Test failed: %Desc%


:Exit
call "%~dp0..\PauseIfGui.bat" "%~f0"
