@echo off

:: %License%

SetLocal DisableDelayedExpansion

set Result=1
set Arg1=%1
set Arg3=%3

SetLocal EnableDelayedExpansion
if .!Arg1! == . EndLocal & call :Usage & goto Exit
if not .!Arg3! == . EndLocal & call :Usage & goto Exit
EndLocal

:: Algorithm derived from http://stackoverflow.com/a/5841587/873131
set "Arg1=%~1#"
SetLocal EnableDelayedExpansion
set StringLength=0
for %%a in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
    if "!Arg1:~%%a,1!" NEQ "" (
        set /a StringLength+=%%a
        set "Arg1=!Arg1:~%%a!"
    )
)
EndLocal & EndLocal & (if ".%~2" == "." (echo.%StringLength%) else (set "%~2=%StringLength%"))
goto Exit


:Usage
echo.
echo.Gets the length of the given string and outputs the result or assigns it to the
echo.specified variable.
echo.
echo.%~n0 String [VariableName]
echo.
echo.  String        The string whose length is retrieved.
echo.
echo.  VariableName  Optionally specifies the name of the environment variable
echo.                to which the length is assigned. If omitted, the length
echo.                is output to stdout.
exit /b


:Exit
@%ComSpec% /c exit %Result% >nul
