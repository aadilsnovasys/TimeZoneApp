# deploy.ps1
param(
    [string]$sourcePath,
    [string]$destinationPath
)

# Stop the IIS site
Write-Host "Stopping IIS site..."
Import-Module WebAdministration
Stop-Website -Name "TimeZoneApp"

# Copy files
Write-Host "Deploying application..."
Remove-Item -Recurse -Force -Path $destinationPath\*
Copy-Item -Path "$sourcePath\*" -Destination $destinationPath -Recurse

# Start the IIS site
Write-Host "Starting IIS site..."
Start-Website -Name "TimeZoneApp"

Write-Host "Deployment completed successfully."
