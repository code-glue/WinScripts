@echo off

SetLocal

set BatchFile=%~dp0..\FileExists.bat

call "%BatchFile%"
if %ErrorLevel% neq 1 echo Failed [empty]

call "%BatchFile%" C:\Windows\notepad.exe
if %ErrorLevel% neq 0 echo Failed C:\Windows\notepad.exe

call "%BatchFile%" C:\Windows
if %ErrorLevel% neq 1 echo Failed C:\Windows

call "%BatchFile%" C:\Windows\system32\cmd.exe
if %ErrorLevel% neq 0 echo Failed C:\Windows\system32\cmd.exe

call "%BatchFile%" C:\
if %ErrorLevel% neq 1 echo Failed C:\
