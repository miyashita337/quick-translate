@echo off
REM Quick Translate - Start as system tray app
REM Place this in shell:startup for auto-start on login
cd /d "%~dp0"
start /min pythonw quick_translate.py
