$domainName = Read-Host "What is the domain name? "
$Cred = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Cred -Authentication Basic -AllowRedirection
Import-PSSession $Session

# Makes sure DKIM is disabled for the domain and then grabs the DNS records needed from Office365
New-DkimSigningConfig -DomainName $domainName -Enabled $false
Get-DkimSigningConfig -Identity $domainName | Format-List Selector1CNAME, Selector2CNAME
Pause

# Only run this after the DNS records from the steps above are added
Set-DkimSigningConfig -Identity $domainName -Enabled $true
Pause

Remove-PSSession $Session