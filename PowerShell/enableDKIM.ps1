$domainName = Read-Host "What is the domain name? "
$Cred = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Cred -Authentication Basic -AllowRedirection
Import-PSSession $Session
# Run any commands you want here
Set-DkimSigningConfig -Identity $domainName -Enabled $true
Pause
Remove-PSSession $Session