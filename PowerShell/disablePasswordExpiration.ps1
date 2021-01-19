$emailAddress = Read-Host "What is the email address you want to disable password expiration for? "
$Cred = Get-Credential
Connect-AzureAD -Credential $Cred

Set-AzureADUser -ObjectId $emailAddress -PasswordPolicies DisablePasswordExpiration