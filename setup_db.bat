@echo off
REM ============================================================
REM  OneReserve — Database Auto-Setup Script (Windows Batch)
REM  Usage: setup_db.bat
REM ============================================================

setlocal enabledelayedexpansion
cd /d "%~dp0"

set USER=root
set PASS=Lopa02468
set DB=onereserve

echo.
echo ======================================================
echo   OneReserve Database Auto-Setup
echo ======================================================
echo.

REM Check MySQL connection
echo [*] Checking MySQL connection...
mysql -u %USER% -p%PASS% -e "SELECT 1;" >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Cannot connect to MySQL
    exit /b 1
)
echo [OK] MySQL is accessible
echo.

REM Import schema
echo [1/8] Importing schema...
mysql -u %USER% -p%PASS% < sql\schema\01_schema.sql
if errorlevel 1 (echo [ERROR] Schema import failed & exit /b 1)
echo [OK] Schema imported
echo.

REM Import seed data
echo [2/8] Importing core data...
mysql -u %USER% -p%PASS% < sql\seeds\02_seed_core.sql
if errorlevel 1 (echo [ERROR] Core seed import failed & exit /b 1)
echo [OK] Core data imported
echo.

echo [3/8] Importing hotels...
mysql -u %USER% -p%PASS% < sql\seeds\03_seed_hotels.sql
if errorlevel 1 (echo [ERROR] Hotels seed import failed & exit /b 1)
echo [OK] Hotels imported
echo.

echo [4/8] Importing users and bookings...
mysql -u %USER% -p%PASS% < sql\seeds\04_seed_users_bookings.sql
if errorlevel 1 (echo [ERROR] Users/bookings seed import failed & exit /b 1)
echo [OK] Users and bookings imported
echo.

echo [5/8] Importing views...
mysql -u %USER% -p%PASS% < sql\views\05_views.sql
if errorlevel 1 (echo [ERROR] Views import failed & exit /b 1)
echo [OK] Views created
echo.

echo [6/8] Importing triggers...
mysql -u %USER% -p%PASS% < sql\triggers\06_triggers.sql
if errorlevel 1 (echo [ERROR] Triggers import failed & exit /b 1)
echo [OK] Triggers created
echo.

echo [7/8] Importing procedures...
mysql -u %USER% -p%PASS% < sql\procedures\07_procedures.sql
if errorlevel 1 (echo [ERROR] Procedures import failed & exit /b 1)
echo [OK] Procedures created
echo.

echo [8/8] Importing functions...
mysql -u %USER% -p%PASS% < sql\functions\08_functions.sql
if errorlevel 1 (echo [ERROR] Functions import failed & exit /b 1)
echo [OK] Functions created
echo.

REM Verify data
echo [*] Verifying seed data...
mysql -u %USER% -p%PASS% -D %DB% -N -e "SELECT CONCAT('Places: ', COUNT(*)) FROM places UNION ALL SELECT CONCAT('Schedules: ', COUNT(*)) FROM schedules UNION ALL SELECT CONCAT('Hotels: ', COUNT(*)) FROM hotels UNION ALL SELECT CONCAT('Room Types: ', COUNT(*)) FROM room_types UNION ALL SELECT CONCAT('Users: ', COUNT(*)) FROM users;"
echo.

echo ======================================================
echo  SUCCESS! Database setup complete
echo ======================================================
echo.
echo Next steps:
echo   1. Activate Python venv:     .venv\Scripts\activate.bat
echo   2. Install dependencies:     pip install -r requirements.txt
echo   3. Start the Flask app:      python app.py
echo   4. Open browser:             http://127.0.0.1:5000
echo.
echo ======================================================
