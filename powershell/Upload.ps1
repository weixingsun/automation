# Usage: .\Upload.ps1 -IP "10.67.246.109" 
#                       -User "Administrator" 
#                       -Pswd "password" 
#                       -RemoteFile  "C:\Users\Administrator\Desktop\output.txt" 
#                       -LocalFile "C:\Users\weixisun\Desktop\Powershell\output.dr.txt"

# .\Download.ps1 -IP "10.67.246.109" -User "Administrator" -Pswd "password" -RemoteFile  "C:\Users\Administrator\Desktop\output.txt" -LocalFile "C:\Users\weixisun\Desktop\Powershell\output.dr.txt"
param($IP, $User, $Pswd, $RemoteFile, $LocalFile)
"Uploading File $IP@$RemoteFile  ->  $LocalFile"

$pw = convertto-securestring -AsPlainText -Force -String $Pswd
$cred = New-Object -typename System.Management.Automation.PSCredential -argumentlist $User,$pw
$session = New-PSsession -ComputerName $IP -credential $cred;

$RemoteComputers = @($IP,$IP)
ForEach ($Computer in $RemoteComputers){
	Try{
		#Copy-Item -Force -Path Start.ps1 -ToSession $session -Destination "$dest_file";
		Copy-Item -Force -ToSession $session -Path $LocalFile -Destination $RemoteFile;
	}Catch{
		Add-Content TaskErrors.txt "Downloading File $Computer@$RemoteDir\$FileName   $Error[0]"
		#Write-Warning $Computer   $Error[0]
	}
}
