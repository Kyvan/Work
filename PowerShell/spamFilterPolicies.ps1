# Variables to be used
$adminUserName = Read-Host "What is the admin user name?"
$direction = Read-Host "Are you looking for Inbound, Outbound, or both direction rules?"

Connect-ExchangeOnline -UserPrincipalName $adminUserName

if ( $direction.ToLower() -ilike "inbound") {
    Get-HostedInboundSpamFilterPolicy
} elseif ( $direction.ToLower() -ilike "outbound") {
    Get-HostedOutboundSpamFilterPolicy 
} elseif ( $direction.ToLower() -ilike "both") {
    Get-HostedOutboundSpamFilterPolicy
    Get-HostedInboundSpamFilterPolicy
} else {
    Write-Host "Please run the script again with either Inbound, Outbound, or both as answer"
}

