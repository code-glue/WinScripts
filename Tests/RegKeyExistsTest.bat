@echo off

SetLocal

set BatchFile=%~dp0..\RegKeyExists.bat
pushd "%~dp0"

set Desc=[empty]
call "%BatchFile%"
if %ErrorLevel% neq 1 goto ExitFail

set Desc=2 args
call "%BatchFile%" a b >nul
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

set Desc=1 Double quote
call "%BatchFile%" "
if %ErrorLevel% neq 1 goto ExitFail

set Desc=2 Double quotes
call "%BatchFile%" ""
if %ErrorLevel% neq 1 goto ExitFail

set Desc=/?
call "%BatchFile%" /? >nul
if %ErrorLevel% neq 1 goto ExitFail

set Desc="/?"
call "%BatchFile%" "/?" >nul
if %ErrorLevel% neq 1 goto ExitFail

set Desc="/?""
call "%BatchFile%" "/?"" >nul
if %ErrorLevel% neq 1 goto ExitFail

set Desc=/
call "%BatchFile%" /
if %ErrorLevel% neq 1 goto ExitFail

set Desc="/"
call "%BatchFile%" "/"
if %ErrorLevel% neq 1 goto ExitFail

set Desc=\
call "%BatchFile%" \
if %ErrorLevel% neq 1 goto ExitFail

set Desc="\"
call "%BatchFile%" "\"
if %ErrorLevel% neq 1 goto ExitFail

set Desc=*
call "%BatchFile%" *
if %ErrorLevel% neq 1 goto ExitFail

set Desc="*"
call "%BatchFile%" "*"
if %ErrorLevel% neq 1 goto ExitFail

set Desc=?
call "%BatchFile%" ?
if %ErrorLevel% neq 1 goto ExitFail

set Desc="?"
call "%BatchFile%" "?"
if %ErrorLevel% neq 1 goto ExitFail

set Desc=C:\?
call "%BatchFile%" C:\?
if %ErrorLevel% neq 1 goto ExitFail

set Desc="C:\?"
call "%BatchFile%" "C:\?"
if %ErrorLevel% neq 1 goto ExitFail

set Desc="?\?"
call "%BatchFile%" "?\?"
if %ErrorLevel% neq 1 goto ExitFail

set Desc="HKCR\! WinScripts Test"
call "%BatchFile%" "HKCR\! WinScripts Test"
if %ErrorLevel% neq 1 goto ExitFail

:: Add registry values for testing
regedit /s RegKeyExistsTest1.reg

set Desc="HKCR\! WinScripts Test"
call "%BatchFile%" "HKCR\! WinScripts Test"
if %ErrorLevel% neq 0 goto ExitFail

set Desc="HKCR\! WinScripts Test\["
call "%BatchFile%" "HKCR\! WinScripts Test\["
if %ErrorLevel% neq 1 goto ExitFail

set Desc="HKCR\! WinScripts Test\]"
call "%BatchFile%" "HKCR\! WinScripts Test\]"
if %ErrorLevel% neq 1 goto ExitFail

set Desc="HKCR\! WinScripts Test\!"
call "%BatchFile%" "HKCR\! WinScripts Test\!"
if %ErrorLevel% neq 1 goto ExitFail

set Desc="HKCR\! WinScripts Test\?"
call "%BatchFile%" "HKCR\! WinScripts Test\?"
if %ErrorLevel% neq 1 goto ExitFail

set Desc="HKCR\! WinScripts Test\&"
call "%BatchFile%" "HKCR\! WinScripts Test\&"
if %ErrorLevel% neq 1 goto ExitFail

set Desc="HKCR\! WinScripts Test\""
call "%BatchFile%" "HKCR\! WinScripts Test\""
if %ErrorLevel% neq 1 goto ExitFail

:: Add registry values for testing
regedit /s RegKeyExistsTest2.reg

set Desc="HKCR\! WinScripts Test\["
call "%BatchFile%" "HKCR\! WinScripts Test\["
if %ErrorLevel% neq 0 goto ExitFail

set Desc="HKCR\! WinScripts Test\]"
call "%BatchFile%" "HKCR\! WinScripts Test\]"
if %ErrorLevel% neq 0 goto ExitFail

set Desc="HKCR\! WinScripts Test\!"
call "%BatchFile%" "HKCR\! WinScripts Test\!"
if %ErrorLevel% neq 0 goto ExitFail

set Desc="HKCR\! WinScripts Test\?"
call "%BatchFile%" "HKCR\! WinScripts Test\?"
if %ErrorLevel% neq 0 goto ExitFail

set Desc="HKCR\! WinScripts Test\&"
call "%BatchFile%" "HKCR\! WinScripts Test\&"
if %ErrorLevel% neq 0 goto ExitFail

set Desc="HKCR\! WinScripts Test\""
call "%BatchFile%" "HKCR\! WinScripts Test\""
if %ErrorLevel% neq 0 goto ExitFail


echo.
echo All tests passed
goto Exit


:ExitFail
echo.
echo Test failed: %Desc%


:Exit
:: Remove registry values for testing
(reg delete "HKCR\! WinScripts Test" /f)>nul 2>&1
popd
call "%~dp0..\PauseGui.bat" "%~f0"
