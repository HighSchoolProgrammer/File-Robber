@echo off
title File Robber Launcher
REM This file installs python.

REM Check if Python is installed
py --version >nul 2>&1
echo Checking if Python is installed...
if errorlevel 1 (
    REM Python is not installed, run the installer
    echo Installing Python...
    assets\python-installer-3.12.4-amd64.exe /passive Include_launcher=1 Include_pip=1 Include_test=0 AppendPath=1 AssociateFiles=1
    cls
    echo Installation Complete. Please relaunch start.bat. 
    echo You may now close this window.
    pause
    echo Exiting...
    exit
) else (
    echo Python is already installed
)

echo Updating pip...
REM Check if pip is on the latest version and update
python -m pip install --upgrade pip 

REM --- DEPENDENCIES ---
echo Importing dependencies...

REM Install Colorama
python -c "import colorama" >nul 2>&1
if errorlevel 1 (
    echo Installing Colorama...
    pip install colorama 
) else (
    echo Colorama package is already installed
)

REM Install tqdm
python -c "import tqdm" >nul 2>&1
if errorlevel 1 (
    echo Installing tqdm...
    pip install tqdm 
) else (
    echo tqdm package is already installed
)

REM --------------------

echo Starting File Robber...

REM Run main.py
title File Robber
cls
python main.py