@echo off
setlocal enabledelayedexpansion

set "YTDLP_EXECUTABLE=yt-dlp.exe"
set "OUTPUT_DIR=%cd%"

:download_video
:: Check if yt-dlp.exe is present in the script's folder
if not exist "%YTDLP_EXECUTABLE%" (
    echo ERROR: yt-dlp.exe not found in the script's folder.
    echo Please download yt-dlp.exe from https://github.com/yt-dlp/yt-dlp/releases
    echo and place it in the same folder as this script.
    pause
    exit /b 1
)

echo Video_DL v0.1
echo =============
echo Enter the video URL:
set /p "VIDEO_URL="

:: Get current date and time to use as part of the filename
for /f "delims=" %%a in ('wmic OS Get localdatetime ^| find "."') do set "DATETIME=%%a"
set "FILENAME=!DATETIME:~0,8!-!DATETIME:~8,4!"

:: List available formats and resolutions
%YTDLP_EXECUTABLE% --list-formats %VIDEO_URL%

:: Prompt the user to select a format
set /p "CHOICE=Enter the number corresponding to the desired resolution: "

:: Check if CHOICE is a valid number and within the range of available formats
set "CHOICE_VALID=1"
for /f "delims=0123456789" %%i in ("%CHOICE%") do set "CHOICE_VALID=0"
if not !CHOICE_VALID! equ 1 (
    echo ERROR: Invalid input. Please enter a valid number.
    pause
    exit /b 1
)

:: Download the video with the chosen format and the best available audio
%YTDLP_EXECUTABLE% --format "%CHOICE%+bestaudio[ext=m4a]/best[ext=mp4]/best" -o "%OUTPUT_DIR%\!FILENAME!.mp4" %VIDEO_URL%

if %errorlevel% neq 0 (
    echo ERROR: Failed to download the video.
    pause
    exit /b 1
)

echo Video downloaded successfully.

:: Ask the user if they want to download another video
set /p "DOWNLOAD_ANOTHER=Do you want to download another video? (y/n): "
if /i "%DOWNLOAD_ANOTHER%" EQU "y" goto :download_video

endlocal
