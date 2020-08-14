# Usage: .\Permission.ps1

# Disable firewall
netsh advfirewall set privateprofile state off
netsh advfirewall set publicprofile state off
netsh advfirewall set domainprofile state off

# Enable-PSRemoting -Force
Enable-PSRemoting -SkipNetworkProfileCheck -Force

# Trust all hosts
Set-Item WSMan:\localhost\Client\TrustedHosts -Value * -Force
# Get-Item WSMan:\localhost\Client\TrustedHosts

# Auto-start WinRM
Set-Service WinRM -StartMode Automatic

# Restart WinRM
Restart-Service -Force WinRM

# Check WinRM PID
Get-WmiObject -Class win32_service | Where-Object {$_.name -like "WinRM"}

# Test
# Test-WsMan dr

