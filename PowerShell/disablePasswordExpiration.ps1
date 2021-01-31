$emailAddress = Read-Host "What is the email address you want to disable password expiration for? "
$cred = Get-Credential
Connect-AzureAD -Credential $cred

Set-AzureADUser -ObjectId $emailAddress -PasswordPolicies DisablePasswordExpiration