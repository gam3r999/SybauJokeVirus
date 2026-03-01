@echo off
echo ================================
echo  SYBAU VIRUS - EXE BUILDER
echo ================================

:: Install dependencies
echo [1/3] Installing requirements...
pip install pyinstaller pygame pillow numpy --quiet

:: Build the exe
echo [2/3] Compiling to EXE...
pyinstaller ^
    --onefile ^
    --noconsole ^
    --name "svchost" ^
    --add-data "sybau.png;." ^
    --add-data "ltg-sybau.mp3;." ^
    --add-data "byebyte.wav;." ^
    sybau_virus.py

:: Copy assets next to the exe
echo [3/3] Copying assets to dist folder...
copy sybau.png dist\
copy ltg-sybau.mp3 dist\
copy byebyte.wav dist\

echo.
echo ================================
echo  DONE! Find your EXE in: dist\svchost.exe
echo ================================
pause
