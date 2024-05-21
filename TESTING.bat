@echo off

REM Get the current directory of the batch script
set "scriptdir=%~dp0"

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
            echo ----VBSCRIPT----
            echo Running VBScript: %%~nxf
            cscript "%%f"
            echo ----------------s
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