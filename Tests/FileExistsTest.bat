@echo off

SetLocal

set BatchFile=%~dp0..\FileExists.bat

set Desc=[empty]
call "%BatchFile%"
if %ErrorLevel% neq 1 goto ExitFail

set Desc=Valid file: C:\Windows\notepad.exe
call "%BatchFile%" C:\Windows\notepad.exe
if %ErrorLevel% neq 0 goto ExitFail

set Desc=Valid directory: C:\Windows
call "%BatchFile%" C:\Windows
if %ErrorLevel% neq 1 goto ExitFail

set Desc=Valid file: C:\Windows\system32\cmd.exe
call "%BatchFile%" C:\Windows\system32\cmd.exe
if %ErrorLevel% neq 0 goto ExitFail

set Desc=Valid drive: C:\
call "%BatchFile%" C:\
if %ErrorLevel% neq 1 goto ExitFail

set Desc=Valid file: C:\Windows\system32\explorer.exe
call "%BatchFile%" C:\Windows\system32\explorer.exe
if %ErrorLevel% neq 0 goto ExitFail

set Desc=Missing file: C:\Windows\notepad.exeXXXXXX
call "%BatchFile%" C:\Windows\notepad.exeXXXXXX
if %ErrorLevel% neq 1 goto ExitFail


echo.
echo All tests passed
goto Exit


:ExitFail
echo.
echo Test failed: %Desc%


:Exit
call "%~dp0..\PauseIfGui.bat" "%~f0"
