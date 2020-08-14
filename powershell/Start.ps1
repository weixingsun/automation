$hostname = get-content env:computername
Write-Host "This is executed on: $hostname"
$output = "C:\Users\Administrator\Desktop\output.txt"
Set-Content -Path $output -Value "This is executed on: $hostname"