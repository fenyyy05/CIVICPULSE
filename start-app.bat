@echo off
echo ============================================================
echo   Starting CivicPulse - Smart City Civic Intelligence
echo ============================================================

REM Check if mysqld is running
tasklist /fi "imagename eq mysqld.exe" | find /i "mysqld.exe" > nul
if errorlevel 1 (
    echo [1/2] Starting MySQL Server 5.5 in background...
    start "" "C:\Program Files\MySQL\MySQL Server 5.5\bin\mysqld.exe" --datadir="C:\ProgramData\MySQL\MySQL Server 5.5\data"
    timeout /t 3 > nul
) else (
    echo [1/2] MySQL Server is already running.
)

echo [2/2] Launching CivicPulse Web Application...
start http://localhost:5000
dotnet run --launch-profile http
pause
