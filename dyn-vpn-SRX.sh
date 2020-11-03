# Configure / Network / DHCP / DHCP Server 
set access address-assignment pool dyn-vpn-address-pool family inet network 10.100.69.0/24
set access address-assignment pool dyn-vpn-address-pool family inet range range1 low 10.100.69.69
set access address-assignment pool dyn-vpn-address-pool family inet range range1 high 10.100.69.169
set access address-assignment pool dyn-vpn-address-pool family inet xauth-attributes primary-dns 192.168.69.1/32

# Configure / Users / Access Profile
set access profile dyn-vpn-access-profile client client1 firewall-user password "DNSt3c4!"
set access profile dyn-vpn-access-profile client client2 firewall-user password "DNSt3c4!"
set access profile dyn-vpn-access-profile address-assignment pool dyn-vpn-address-pool

# Configure / Users / FW Authentication
set access firewall-authentication web-authentication default-profile dyn-vpn-access-profile

# Configure / Security Services / IPsec VPN / IKE (Phase I)
set security ike policy ike-dyn-vpn-policy mode aggressive
set security ike policy ike-dyn-vpn-policy proposal-set standard
set security ike policy ike-dyn-vpn-policy pre-shared-key ascii-text "$ABC789"
set security ike gateway dyn-vpn-local-gw ike-policy ike-dyn-vpn-policy
set security ike gateway dyn-vpn-local-gw dynamic hostname dynvpn
set security ike gateway dyn-vpn-local-gw dynamic connections-limit 10
set security ike gateway dyn-vpn-local-gw dynamic ike-user-type group-ike-id
set security ike gateway dyn-vpn-local-gw external-interface ge-0/0/5.0
set security ike gateway dyn-vpn-local-gw aaa access-profile dyn-vpn-access-profile

# Configure / Security Services / IPsec VPN / IPsec (Phase II)
set security ipsec policy ipsec-dyn-vpn-policy proposal-set standard
set security ipsec vpn dyn-vpn ike gateway dyn-vpn-local-gw
set security ipsec vpn dyn-vpn ike ipsec-policy ipsec-dyn-vpn-policy

# Configure / Security Services / Security Policy / Rules
set security policies from-zone untrust to-zone trust policy dyn-vpn-policy match source-address any
set security policies from-zone untrust to-zone trust policy dyn-vpn-policy match destination-address any
set security policies from-zone untrust to-zone trust policy dyn-vpn-policy match application any
set security policies from-zone untrust to-zone trust policy dyn-vpn-policy then permit tunnel ipsec-vpn dyn-vpn



#### Issue is with the configs below ####
# Configure / Security Services / IPsec VPN / Dynamic VPN
set security dynamic-vpn access-profile dyn-vpn-access-profile
set security dynamic-vpn clients all remote-protected-resources 10.0.0.0/8
set security dynamic-vpn clients all remote-exceptions 0.0.0.0/0
set security dynamic-vpn clients all ipsec-vpn dyn-vpn
set security dynamic-vpn clients all user client1
set security dynamic-vpn clients all user client2



[edit security ike gateway dyn-vpn-local-gw aaa]
  'access-profile'
    Unable to access attribute as a string
[edit security ike gateway dyn-vpn-local-gw]
  'aaa'
    Missing xauth access profile for IKE gateway dyn-vpn-local-gw for ipsec_vpn dyn-vpn
error: configuration check-out failed


#### POTENTIAL CONFIGS THAT MIGHT WORK ####
Using vpnc with Juniper / Junos / SRX
-------------------------------------

Breif instructions for using vpnc with the dynamic vpn feature of the
SRX.  Make sure your SRX config is set up with "shared-ike-id".  Make
sure the SRX "dynamic hostname" matches the vpnc "IPSec ID".

Example VPNC Config
-------------------
  Vendor juniper
  IPSec gateway 192.168.10.1
  IPSec ID example.com
  IPSec secret TheGroupSecret
  Xauth username joe
  Xauth password joespw
  IKE Authmode psk
  IKE DH Group dh2
  Perfect Forward Secrecy dh2

Example SRX Config
------------------
  # IKE Phase 1
  set security ike policy DYN-VPN-IKE mode aggressive
  set security ike policy DYN-VPN-IKE proposal-set standard
  set security ike policy DYN-VPN-IKE pre-shared-key ascii-text "TheGroupSecret"
  set security ike gateway DYN-VPN-GW ike-policy DYN-VPN-IKE
  set security ike gateway DYN-VPN-GW dynamic hostname dnsnetworks.io
  set security ike gateway DYN-VPN-GW dynamic connections-limit 10
  set security ike gateway DYN-VPN-GW dynamic ike-user-type shared-ike-id
  set security ike gateway DYN-VPN-GW external-interface ge-0/0/5.0
  set security ike gateway DYN-VPN-GW xauth access-profile DYN-VPN-PROFILE
  
  # IKE Phase 2
  set security ipsec policy DYN-VPN-IPSEC-POLICY perfect-forward-secrecy keys group2
  set security ipsec policy DYN-VPN-IPSEC-POLICY proposal-set standard
  set security ipsec vpn DYN-VPN-IPSEC ike gateway DYN-VPN-GW
  set security ipsec vpn DYN-VPN-IPSEC ike ipsec-policy DYN-VPN-IPSEC-POLICY
  
  # VPN
  #   laptop[joe@example.com] <======> 192.168.10.1[example.com] <-----> 10.69.69.0/24[internal]
  set access profile DYN-VPN-PROFILE address-assignment pool DYN-VPN-POOL
  set access address-assignment pool DYN-VPN-POOL family inet network 10.69.69.0/24
  set access address-assignment pool DYN-VPN-POOL family inet range dvpn-range low 10.69.69.24
  set access address-assignment pool DYN-VPN-POOL family inet range dvpn-range high 10.69.69.96
  set access address-assignment pool DYN-VPN-POOL family inet xauth-attributes primary-dns 8.8.8.8/32
  set security dynamic-vpn access-profile DYN-VPN-PROFILE
  set security dynamic-vpn clients all remote-protected-resources 192.168.69.1/24
  set security dynamic-vpn clients all remote-exceptions 0.0.0.0/0
  set security dynamic-vpn clients all ipsec-vpn DYN-VPN-IPSEC
  set security policies from-zone untrust to-zone trust policy DYN-VPN match source-address any
  set security policies from-zone untrust to-zone trust policy DYN-VPN match destination-address any
  set security policies from-zone untrust to-zone trust policy DYN-VPN match application any
  set security policies from-zone untrust to-zone trust policy DYN-VPN then permit tunnel ipsec-vpn DYN-VPN-IPSEC
  set access firewall-authentication web-authentication default-profile DYN-VPN-PROFILE
  
  # Local firewall user (joe)
  set access profile DYN-VPN-PROFILE client client1 firewall-user password "DNSt3c4!"
  set security dynamic-vpn clients all user client1


  delete security policies from-zone untrust to-zone trust policy DYN-VPN match source-address any
  delete security policies from-zone untrust to-zone trust policy DYN-VPN match destination-address any
  delete security policies from-zone untrust to-zone trust policy DYN-VPN match application any
  delete security policies from-zone untrust to-zone trust policy DYN-VPN then permit tunnel ipsec-vpn DYN-VPN-IPSEC