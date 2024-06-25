@echo off
setlocal enabledelayedexpansion

echo Gathering Computer Data...

REM Get the current directory of the batch script
set "scriptdir=%~dp0"

REM -- DEPENDENCIES --
REM None yet :)s
REM ------------------

REM Get the computer name
for /F "tokens=2 delims==." %%a in ('wmic os get csname /value') do set "computername=%%a"

REM Create the folder name with computer name
set "outputfolder=output"

REM -- PROGRAM INFO --



echo %scriptdir%
echo %scriptdir%config.txt
echo Program Name: %name%
echo Program Version Type: %version-type%
echo Program Version: %version%
echo Program Author: %author%
echo Program License: %license%
echo Program Repository: %repository%
REM ------------------

pause