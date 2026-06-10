param(
    [string]$User = "root",
    [string]$Pass = ""
)

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptRoot

function Run-SqlFile([string]$file) {
    Write-Host "Running $file..."
    if (-not (Get-Command mysql -ErrorAction SilentlyContinue)) {
        Write-Error "MySQL client 'mysql' not found. Install MySQL or add it to PATH."
        exit 1
    }
    if ($Pass -eq "") {
        Get-Content $file | mysql -u $User
    } else {
        Get-Content $file | mysql -u $User -p$Pass
    }
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to execute $file"
        exit $LASTEXITCODE
    }
}

Write-Host "OneReserve Database Setup for Windows"
Write-Host "User: $User"
if ($Pass) { Write-Host "Password: [REDACTED]" }

Run-SqlFile "$scriptRoot/schema/01_schema.sql"
Run-SqlFile "$scriptRoot/seeds/02_seed_core.sql"
Run-SqlFile "$scriptRoot/seeds/03_seed_hotels.sql"
Run-SqlFile "$scriptRoot/seeds/04_seed_users_bookings.sql"
Run-SqlFile "$scriptRoot/views/05_views.sql"
Run-SqlFile "$scriptRoot/triggers/06_triggers.sql"
Run-SqlFile "$scriptRoot/procedures/07_procedures.sql"
Run-SqlFile "$scriptRoot/functions/08_functions.sql"

Write-Host "✅ Database ready. Run: python app.py" -ForegroundColor Green
