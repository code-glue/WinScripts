@echo off

SetLocal

set BatchFile=%~dp0..\FileExists.bat

call "%BatchFile%"
if %ErrorLevel% neq 1 echo Failed

call "%BatchFile%" C:\Windows\notepad.exe
if %ErrorLevel% neq 0 echo Failed

call "%BatchFile%" C:\Windows
if %ErrorLevel% neq 1 echo Failed

call "%BatchFile%" C:\Windows\system32\explorer.exe
if %ErrorLevel% neq 0 echo Failed

call "%BatchFile%" C:\
if %ErrorLevel% neq 1 echo Failed
