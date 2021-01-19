$Cred = Get-Credential
Connect-AzureAD -Credential $Cred

# disbales password expiry for all users in the organization
Get-AzureADUser -All $true | Set-AzureADUser -PasswordPolicies DisablePasswordExpiration