@echo off

SetLocal

set BatchFile=%~dp0..\RegKeyExists.bat

call "%BatchFile%"
if %ErrorLevel% neq 1 echo Failed [empty]

call "%BatchFile%" HKCR
if %ErrorLevel% neq 0 echo Failed HKCR

call "%BatchFile%" HKCR\BadPath
if %ErrorLevel% neq 1 echo Failed HKCR\BadPath

call "%BatchFile%" HKCR\.txt
if %ErrorLevel% neq 0 echo Failed HKCR\.txt
