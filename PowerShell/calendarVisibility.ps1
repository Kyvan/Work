$Cred = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Cred -Authentication Basic -AllowRedirection
Import-PSSession $Session

Set-OrganizationConfig -VisibleMeetingUpdateProperties AllProperties
Pause

Remove-PSSession $Session