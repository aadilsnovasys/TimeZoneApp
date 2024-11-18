# Decode Base64 encoded password
$decodedPassword = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($env:SERVER_PASSWORD))

# Create a PowerShell credential object
$securePassword = ConvertTo-SecureString $decodedPassword -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($env:SERVER_USER, $securePassword)

# Create a session with the remote server
$session = New-PSSession -ComputerName $env:SERVER_HOST -Credential $credential

Invoke-Command -Session $session -ScriptBlock {
    # Backup the existing application
    Write-Host "Backing up existing application..."
    New-Item -Path "C:\inetpub\TimeZoneApp\backup" -ItemType Directory -Force
    Move-Item -Path "C:\inetpub\TimeZoneApp\*" -Destination "C:\inetpub\TimeZoneApp\backup" -Force

    # Copy the published files
    Write-Host "Deploying new application files..."
    robocopy "C:\actions-runner\_work\TimeZoneApp\published" "C:\inetpub\TimeZoneApp" /mir

    # Restart IIS
    Write-Host "Restarting IIS..."
    iisreset
}

# Remove the session
Remove-PSSession -Session $session
