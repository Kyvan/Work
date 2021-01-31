$cred = Get-Credential
Connect-AzureAD -Credential $cred

# disbales password expiry for all users in the organization
Get-AzureADUser -All $true | Set-AzureADUser -PasswordPolicies DisablePasswordExpiration