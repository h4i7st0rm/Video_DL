@echo off
setlocal enabledelayedexpansion

set "YTDLP_EXECUTABLE=yt-dlp.exe"
set "OUTPUT_DIR=%cd%"

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

:: Extract the last 7 characters of the video URL to use as the filename
set "FILENAME=!VIDEO_URL:~-7!"

:: List available formats and resolutions
%YTDLP_EXECUTABLE% --list-formats %VIDEO_URL%

:: Prompt the user to select a format
set /p "CHOICE=Enter the number corresponding to the desired resolution: "
%YTDLP_EXECUTABLE% --format "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" -o "%OUTPUT_DIR%\!FILENAME!" %VIDEO_URL%

endlocal
