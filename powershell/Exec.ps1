# Usage: .\Exec.ps1 -IPs "10.67.246.109,10.67.246.109"
#                       -User "Administrator"
#                       -Pswd "password"
#                       -File "C:\Users\weixisun\Desktop\Powershell\Start.ps1"

# .\Exec.ps1 -IPs 10.67.246.109 -User "Administrator" -Pswd "password" -File "C:\Users\weixisun\Desktop\Powershell\Start.ps1"

param($IPs, $User, $Pswd, $File)
"Downloading $File on ($IPs)"

$PW = ConvertTo-SecureString -AsPlainText -Force -String $Pswd
$cred = New-Object -typename System.Management.Automation.PSCredential -argumentlist "AMD\$User",$PW

# $File = "C:\Users\weixisun\Desktop\Powershell\Start.ps1"  ### local file at driver host
# $RemoteComputers = @("10.67.246.109","10.67.246.109")
$RemoteComputers = $IPs.Split(",")  # 10.67.246.109,10.67.246.109
ForEach ($Computer in $RemoteComputers){
	Try{
		Invoke-Command -ComputerName $Computer -credential $cred -FilePath $File  #-ErrorAction Continue/Stop;
	}Catch{
		Add-Content TaskErrors.txt "$Computer $Error[0]"  #Write-Warning $Computer   $Error[0]
	}
}
Write-Host "Done"