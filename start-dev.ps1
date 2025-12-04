# Check if dotnet is installed
if (-not (Get-Command dotnet -ErrorAction SilentlyContinue)) {
    Write-Error "Error: 'dotnet' command not found. Please install .NET SDK."
    exit 1
}

# Check if npm is installed
if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
    Write-Error "Error: 'npm' command not found. Please install Node.js."
    exit 1
}

$scriptPath = $PSScriptRoot

# Start Backend
Write-Host "Starting Backend..." -ForegroundColor Green
$backendPath = Join-Path $scriptPath "backend"
# Opens a new PowerShell window, navigates to backend, and runs dotnet run
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$backendPath'; dotnet run"

# Start Frontend
Write-Host "Starting Frontend..." -ForegroundColor Green
$frontendPath = Join-Path $scriptPath "frontend"
Set-Location $frontendPath

if (-not (Test-Path "node_modules")) {
    Write-Host "Installing frontend dependencies..." -ForegroundColor Yellow
    npm install
}

npm run dev
