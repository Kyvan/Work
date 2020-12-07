$domainName = Read-Host "What is the domain name? "
$Cred = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Cred -Authentication Basic -AllowRedirection
Import-PSSession $Session
# Run any commands you want here
New-DkimSigningConfig -DomainName $domainName -Enabled $false
Get-DkimSigningConfig -Identity $domainName | Format-List Selector1CNAME, Selector2CNAME
Remove-PSSession $Session