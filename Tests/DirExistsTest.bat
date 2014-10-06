@echo off

SetLocal DisableDelayedExpansion

set BatchFile=%~dp0..\DirExists.bat
pushd "%~dp0"

set Desc=[empty]
call "%BatchFile%"
if %ErrorLevel% neq 1 goto ExitFail

set Desc=2 args
call "%BatchFile%" a b >nul
if %ErrorLevel% neq 1 goto ExitFail

set Desc=Valid directory: C:\Windows
call "%BatchFile%" C:\Windows
if %ErrorLevel% neq 0 goto ExitFail

set Desc=Missing directory: C:\WindowsXXXXXX
call "%BatchFile%" C:\WindowsXXXXXX
if %ErrorLevel% neq 1 goto ExitFail

set Desc=Valid drive C:\
call "%BatchFile%" C:\
if %ErrorLevel% neq 0 goto ExitFail

set Desc=Invalid drive A:\
call "%BatchFile%" A:\
if %ErrorLevel% neq 1 goto ExitFail

set Desc=Valid file: C:\Windows\notepad.exe
call "%BatchFile%" C:\Windows\notepad.exe
if %ErrorLevel% neq 1 goto ExitFail

set Desc=Valid file: C:\Windows\system32\explorer.exe
call "%BatchFile%" C:\Windows\system32\explorer.exe
if %ErrorLevel% neq 1 goto ExitFail

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
if %ErrorLevel% neq 0 goto ExitFail

set Desc="/"
call "%BatchFile%" "/"
if %ErrorLevel% neq 0 goto ExitFail

set Desc=\
call "%BatchFile%" \
if %ErrorLevel% neq 0 goto ExitFail

set Desc="\"
call "%BatchFile%" "\"
if %ErrorLevel% neq 0 goto ExitFail

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

set Desc=Absolute directory path: "C:\a! b` c~ d@ e# f$ g( h) i- k= l+ m{ n} o[ p] q. r, s' t; u& v"
mkdir "C:\a! b` c~ d@ e# f$ g( h) i- k= l+ m{ n} o[ p] q. r, s' t; u& v"
call "%BatchFile%" "C:\a! b` c~ d@ e# f$ g( h) i- k= l+ m{ n} o[ p] q. r, s' t; u& v"
rd "C:\a! b` c~ d@ e# f$ g( h) i- k= l+ m{ n} o[ p] q. r, s' t; u& v" /s /q & (if %ErrorLevel% neq 0 goto ExitFail)

set Desc=Relative directory path: "a! b` c~ d@ e# f$ g( h) i- k= l+ m{ n} o[ p] q. r, s' t; u& v"
mkdir "a! b` c~ d@ e# f$ g( h) i- k= l+ m{ n} o[ p] q. r, s' t; u& v"
call "%BatchFile%" "a! b` c~ d@ e# f$ g( h) i- k= l+ m{ n} o[ p] q. r, s' t; u& v"
rd "a! b` c~ d@ e# f$ g( h) i- k= l+ m{ n} o[ p] q. r, s' t; u& v" /s /q & (if %ErrorLevel% neq 0 goto ExitFail)

set Desc=Relative file path: "a! b` c~ d@ e# f$ g( h) i- k= l+ m{ n} o[ p] q. r, s' t; u& v"
echo.>"a! b` c~ d@ e# f$ g( h) i- k= l+ m{ n} o[ p] q. r, s' t; u& v"
call "%BatchFile%" "a! b` c~ d@ e# f$ g( h) i- k= l+ m{ n} o[ p] q. r, s' t; u& v"
del "a! b` c~ d@ e# f$ g( h) i- k= l+ m{ n} o[ p] q. r, s' t; u& v" /q & (if %ErrorLevel% neq 1 goto ExitFail)

set Desc="!"
mkdir "!"
call "%BatchFile%" "!"
rd "!" /s /q & (if %ErrorLevel% neq 0 goto ExitFail)

set Desc=!
mkdir "!"
call "%BatchFile%" !
rd "!" /s /q & (if %ErrorLevel% neq 0 goto ExitFail)

set Desc="!"
call "%BatchFile%" "!"
if %ErrorLevel% neq 1 goto ExitFail

set Desc=!
call "%BatchFile%" !
if %ErrorLevel% neq 1 goto ExitFail


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
