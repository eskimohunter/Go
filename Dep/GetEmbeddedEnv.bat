echo off
setlocal EnableDelayedExpansion
cls

Rem Python Version Def
Set "MajorVersion=3"
Set "MinorVersion=11"
Set "PatchVersion=4"
Set "LeelaVersion=0110"

pushd %~dp0

if exist "python-embed-amd64" rmdir /s /q "python-embed-amd64">nul 2>&1
if exist "python-embed-amd64.zip" del /f /q "python-embed-amd64.zip">nul 2>&1

echo Leela Engine
curl -L --ssl-no-revoke -o "Leela%LeelaVersion%GTP.zip" "https://www.sjeng.org/dl/Leela%LeelaVersion%GTP.zip"
echo.

echo Embedded Python
curl -L --ssl-no-revoke -o "python-embed-amd64.zip" "https://www.python.org/ftp/python/%MajorVersion%.%MinorVersion%.%PatchVersion%/python-%MajorVersion%.%MinorVersion%.%PatchVersion%-embed-amd64.zip"
echo.

mkdir "python-embed-amd64"
tar -xf python-embed-amd64.zip -C ./python-embed-amd64
del /f /q "python-embed-amd64.zip">nul 2>&1
cd python-embed-amd64
echo import site>>python311._pth

Rem Get Pip
echo get-pip.py
curl -L --ssl-no-revoke -o "get-pip.py" "https://bootstrap.pypa.io/get-pip.py"
echo.
python.exe get-pip.py
echo.

Rem get Modules
Scripts\pip.exe install tk
echo.

cd..

echo Zipping...
zip -r python-embed-amd64.zip python-embed-amd64>nul 2>&1

pause

exit 0