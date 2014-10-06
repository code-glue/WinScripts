@echo off

:: %License%

SetLocal DisableDelayedExpansion

set Result=1
set RemotePath=%~1
set LocalPath=%~f2
set SdCardPath=/mnt/sdcard

if [%1] == [] call :Usage & goto Exit
if "%~1" == "/?" call :Usage & goto Exit
if not [%3] == [] call :Usage & goto Exit


adb shell exit >nul
if %ErrorLevel% neq 0 goto Exit

:: Replace " " with "\ " (escape spaces)
set RemotePath=%RemotePath: =\ %

:: Get time stamp, replacing spaces with zeros
set TimeStamp=%date:~-4,4%-%date:~-10,2%-%date:~-7,2%_%time:~-11,2%-%time:~-8,2%-%time:~-5,2%
set TimeStamp=%TimeStamp: =0%

if "%LocalPath%" == "" set LocalPath=adbSuPull_%UserName%_%TimeStamp%
set TempPath=%SdCardPath%/adbSuPull_temp_%TimeStamp%/

echo.
echo Copying to temp location "%TempPath%"
echo.
adb shell "su -c 'mkdir -p %TempPath%; cp -RLv %RemotePath% %TempPath%'"
if %ErrorLevel% neq 0 goto Exit

echo.
echo Copying to destination "%LocalPath%"
echo.
adb pull "%TempPath%" "%LocalPath%"


:Cleanup
echo.
echo Removing temp location "%TempPath%"
echo.
adb shell "rm -Rf '%TempPath%'"
if %ErrorLevel% equ 0 set Result=0
goto Exit


:Usage
echo.
echo Copies files/directories from a rooted Android device to a Windows path.
echo The files are temporarily copied to the directory "%SdCardPath%" on the device.
echo The Android device must have enough free space to allow this operation.
echo.
echo.%~n0 RemotePath [LocalPath]
echo.
echo.  RemotePath   Specifies the path to the file or directory on
echo.               the rooted Android device.
echo.
echo.  LocalPath    Optionally specifies the destination path. This can be a
echo.               Windows local path (C:\folder) or a UNC path
echo.               (\\server\share).
echo.               Defaults to adbSuPull_%%UserName%%_%%TimeStamp%%
echo.               in the current working directory.
exit /b


:Exit
call "%~dp0PauseIfGui.bat" "%~f0"
@%ComSpec% /c exit %Result% >nul
