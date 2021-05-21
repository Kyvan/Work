#!/bin/bash -u

read -rp "What's the company name? " companyName
read -rp "What's the DH group number (number only)? " groupNumber
read -rp "What's the preshared key? " PSK
read -rp "What's the romote Gateway IP? " remoteGateway
read -rp "What's the ST interface logical numeber (number only)? " stLogicalInterface
read -rp "What's the local IP subnet and mask (CIDR format)? " localIPandMask
# read -rp "What's the remote IP subnet and mask (CIDR format)? " remoteIPandMask
read -rp "Which Encryption algorithm is used for Phase1 (3des-cbc, aes-128-cbc, aes-192-cbc, des-cbc, aes-128-gcm, or aes-256-gcm)? " phase1Encryp
read -rp "Which Encryption algorithm is used for Phase2 (des-cbc, 3des-cbc, aes-128-cbc, aes-192-cbc, aes-128-gcm, aes-192-gcm, or aes-256-gcm)? " phase2Encryp
read -rp "Which Authentication algorithm is used for phase1 (md5, sha1, sha-256, sha-384)? " phase1Auth
read -rp "Which Authentication algorithm is used for phase2 (hmac-md5-96, hmac-sha1-96, or hmac-sha-256-128)? " phase2Auth

echo set security ike proposal "$companyName"-rproposal1 authentication-method pre-shared-keys
echo set security ike proposal "$companyName"-rproposal1 dh-group group"$groupNumber"
echo set security ike proposal "$companyName"-rproposal1 authentication-algorithm "$phase1Auth"
echo set security ike proposal "$companyName"-rproposal1 encryption-algorithm "$phase1Encryp"
echo set security ike proposal "$companyName"-rproposal1 lifetime-seconds 28800
echo set security ike policy "$companyName"-rpolicy1 mode main
echo set security ike policy "$companyName"-rpolicy1 proposals "$companyName"-rproposal1
echo set security ike policy "$companyName"-rpolicy1 pre-shared-key ascii-text "$PSK"
echo set security ike gateway "$companyName"-gw ike-rpolicy "$companyName"-rpolicy1
echo set security ike gateway "$companyName"-gw address "$remoteGateway"
echo set security ike gateway "$companyName"-gw dead-rpeer-detection always-send
echo set security ike gateway "$companyName"-gw dead-rpeer-detection interval 10
echo set security ike gateway "$companyName"-gw dead-rpeer-detection threshold 5
echo set security ike gateway "$companyName"-gw local-identity inet 64.26.131.182
echo set security ike gateway "$companyName"-gw external-interface ge-0/0/0.0
echo set security ike gateway "$companyName"-gw version v1-only
echo set security ipsec proposal "$companyName"-rproposal2 protocol esp
echo set security ipsec proposal "$companyName"-rproposal2 authentication-algorithm "$phase2Auth"
echo set security ipsec proposal "$companyName"-rproposal2 encryption-algorithm "$phase2Encryp"
echo set security ipsec proposal "$companyName"-rproposal2 lifetime-seconds 3600
echo set security ipsec policy "$companyName"-rpolicy2 proposals "$companyName"-rproposal2
echo set security ipsec vpn "$companyName"-VPN bind-interface st0."$stLogicalInterface"
echo set security ipsec vpn "$companyName"-VPN ike gateway "$companyName"-gw
echo set security ipsec vpn "$companyName"-VPN ike ipsec-rpolicy "$companyName"-rpolicy2
echo set security ipsec vpn "$companyName"-VPN traffic-selector "$companyName"-Office local-ip "$localIPandMask"
echo set security ipsec vpn "$companyName"-VPN traffic-selector "$companyName"-Office remote-ip "$remoteGateway"
echo set security ipsec vpn "$companyName"-VPN establish-tunnels immediately
echo set routing-options static route "$remoteGateway" next-hop st0."$stLogicalInterface"