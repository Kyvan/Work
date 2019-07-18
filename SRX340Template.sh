#!/bin/bash -u
    read -p "What's the hostname? " hostName
    read -p "What's the Primary DNS? " DNS1
    read -p "What's the Secondaty DNS? " DNS2
    
    set system host-name $hostName
    set system time-zone EST
    set system root-authentication encrypted-password "$5$YeRRXRzL$go4sISMi5K/mfuwCgAK.6ruuYMstcvIH3Ptmvng.I7D"
    set system name-server $DNS1
    set system name-server $DNS2
    set system name-resolution no-resolve-on-input
    set system login user almond uid 2000
    set system login user almond class super-user
    set system login user almond authentication encrypted-password "$5$wIHiGlLC$sVoW/O4FoLzn01eLhSu3R7F/mO6bCM6l8uRls/5Ma13"
    set system services ssh
    set system services telnet
    set system services web-management http interface ge-0/0/1.0
    set system services web-management http interface ge-0/0/0.0
    set system services web-management https system-generated-certificate
    set system services web-management https interface ge-0/0/1.0
    set system services web-management https interface ge-0/0/0.0
    set system services dhcp boot-file undionly.kpxe
    set system services dhcp next-server 192.168.100.195
    set system services dhcp pool 192.168.50.0/24 address-range low 192.168.50.50
    set system services dhcp pool 192.168.50.0/24 address-range high 192.168.50.150
    set system services dhcp pool 192.168.50.0/24 domain-name dnsnetworks.local
    set system services dhcp pool 192.168.50.0/24 name-server 10.200.20.80
    set system services dhcp pool 192.168.50.0/24 name-server 1.1.1.1
    set system services dhcp pool 192.168.50.0/24 router 192.168.50.1
    set system services dhcp pool 192.168.50.0/24 server-identifier 192.168.50.1
    set system services dhcp pool 192.168.75.0/24 address-range low 192.168.75.50
    set system services dhcp pool 192.168.75.0/24 address-range high 192.168.75.200
    set system services dhcp pool 192.168.75.0/24 name-server 8.8.8.8
    set system services dhcp pool 192.168.75.0/24 name-server 8.8.4.4
    set system services dhcp pool 192.168.75.0/24 router 192.168.75.1
    set system services dhcp pool 192.168.75.0/24 server-identifier 192.168.75.1
    set system services dhcp pool 192.168.100.0/24 address-range low 192.168.100.50
    set system services dhcp pool 192.168.100.0/24 address-range high 192.168.100.200
    set system services dhcp pool 192.168.100.0/24 name-server 8.8.8.8
    set system services dhcp pool 192.168.100.0/24 name-server 8.8.4.4
    set system services dhcp pool 192.168.100.0/24 router 192.168.100.1
    set system services dhcp pool 192.168.100.0/24 server-identifier 192.168.100.1
    set system services dhcp static-binding a0:d3:c1:2a:d3:65 fixed-address 192.168.50.114
    set system services dhcp static-binding a0:d3:c1:2a:d3:65 host-name Tim-DevBox
    set system services dhcp static-binding ec:b1:d7:2e:30:ac fixed-address 192.168.50.75
    set system services dhcp static-binding ec:b1:d7:2e:30:ac host-name Tim-PC
    set system services dhcp static-binding f0:9f:c2:56:91:dc fixed-address 192.168.50.83
    set system services dhcp static-binding f0:9f:c2:56:91:dc host-name UniFi-AP
    set system services dhcp static-binding 00:04:f2:81:ef:fc fixed-address 192.168.50.102
    set system services dhcp static-binding 00:04:f2:81:ef:fc host-name Phone
    set system services dhcp static-binding b4:f7:a1:be:eb:c9 fixed-address 192.168.50.59
    set system services dhcp static-binding b4:f7:a1:be:eb:c9 host-name Tim-CellPhone
    set system services dhcp static-binding 8c:dc:d4:2f:d1:02 fixed-address 192.168.50.82
    set system services dhcp static-binding 8c:dc:d4:2f:d1:02 host-name Kyvan-PC
    set system services dhcp static-binding 00:0c:29:40:af:e3 fixed-address 192.168.50.111
    set system services dhcp static-binding 00:0c:29:40:af:e3 host-name OpenVas
    set system syslog archive size 100k
    set system syslog archive files 3
    set system syslog user * any emergency
    set system syslog file messages any critical
    set system syslog file messages authorization info
    set system syslog file interactive-commands interactive-commands error
    set system syslog file kmd-logs daemon info
    set system syslog file kmd-logs match KMD
    set system max-configurations-on-flash 5
    set system max-configuration-rollbacks 5
    set system license autoupdate url https://ae1.juniper.net/junos/key_retrieval
    set system ntp server time.nrc.ca
    set chassis fpc 1 pic 0 q-pic-large-buffer large-scale
    set security ike proposal AD-Proposal1 authentication-method pre-shared-keys
    set security ike proposal AD-Proposal1 dh-group group14
    set security ike proposal AD-Proposal1 authentication-algorithm sha-256
    set security ike proposal AD-Proposal1 encryption-algorithm aes-256-cbc
    set security ike proposal AD-Proposal1 lifetime-seconds 28800
    set security ike policy AD-Policy1 mode main
    set security ike policy AD-Policy1 proposals AD-Proposal1
    set security ike policy AD-Policy1 pre-shared-key ascii-text "$9$tnuHuEcleM-VYlKoGUjf5IEcyrvdVYZUH24ZDHkQzIEcSK87-V"
    set security ike gateway AD-Gateway ike-policy AD-Policy1
    set security ike gateway AD-Gateway address 75.98.140.12
    set security ike gateway AD-Gateway external-interface ge-0/0/0.0
    set security ike gateway AD-Gateway version v1-only
    set security ipsec traceoptions flag all
    set security ipsec proposal AD-Porposal2 protocol esp
    set security ipsec proposal AD-Porposal2 authentication-algorithm hmac-sha-256-128
    set security ipsec proposal AD-Porposal2 encryption-algorithm aes-256-cbc
    set security ipsec proposal AD-Porposal2 lifetime-seconds 3600
    set security ipsec policy AD-Policy2 perfect-forward-secrecy keys group14
    set security ipsec policy AD-Policy2 proposals AD-Porposal2
    set security ipsec vpn AD-VPN bind-interface st0.2
    set security ipsec vpn AD-VPN ike gateway AD-Gateway
    set security ipsec vpn AD-VPN ike ipsec-policy AD-Policy2
    set security ipsec vpn AD-VPN establish-tunnels immediately
    set security screen ids-option untrust-screen icmp ping-death
    set security screen ids-option untrust-screen ip source-route-option
    set security screen ids-option untrust-screen ip tear-drop
    set security screen ids-option untrust-screen tcp syn-flood alarm-threshold 1024
    set security screen ids-option untrust-screen tcp syn-flood attack-threshold 200
    set security screen ids-option untrust-screen tcp syn-flood source-threshold 1024
    set security screen ids-option untrust-screen tcp syn-flood destination-threshold 2048
    set security screen ids-option untrust-screen tcp syn-flood timeout 20
    set security screen ids-option untrust-screen tcp land
    set security nat source pool Fibrenoir-Pool address 75.98.134.186/32
    set security nat source rule-set nsw_srcnat from zone Dev
    set security nat source rule-set nsw_srcnat from zone Internal
    set security nat source rule-set nsw_srcnat from zone VoIP
    set security nat source rule-set nsw_srcnat to zone Internet
    set security nat source rule-set nsw_srcnat rule DNSOffice-to-DNSAD match source-address 192.168.50.0/24
    set security nat source rule-set nsw_srcnat rule DNSOffice-to-DNSAD match source-address 192.168.75.0/24
    set security nat source rule-set nsw_srcnat rule DNSOffice-to-DNSAD match source-address 192.168.100.0/24
    set security nat source rule-set nsw_srcnat rule DNSOffice-to-DNSAD match destination-address 10.200.20.80/32
    set security nat source rule-set nsw_srcnat rule DNSOffice-to-DNSAD match destination-address 10.200.20.81/32
    set security nat source rule-set nsw_srcnat rule DNSOffice-to-DNSAD match protocol tcp
    set security nat source rule-set nsw_srcnat rule DNSOffice-to-DNSAD match protocol udp
    set security nat source rule-set nsw_srcnat rule DNSOffice-to-DNSAD then source-nat off
    set security nat source rule-set nsw_srcnat rule nsw-src-interface match source-address 192.168.0.0/16
    set security nat source rule-set nsw_srcnat rule nsw-src-interface match destination-address 0.0.0.0/0
    set security nat source rule-set nsw_srcnat rule nsw-src-interface match protocol tcp
    set security nat source rule-set nsw_srcnat rule nsw-src-interface match protocol udp
    set security nat source rule-set nsw_srcnat rule nsw-src-interface then source-nat pool Fibrenoir-Pool
    set security nat destination pool ESXPortForward address 192.168.50.211/32
    set security nat destination pool ESXPortForward address port 443
    set security nat destination rule-set ESXRemoteManagement from zone Internet
    set security nat destination rule-set ESXRemoteManagement rule External-to-ESX match source-address 0.0.0.0/0
    set security nat destination rule-set ESXRemoteManagement rule External-to-ESX match destination-address 75.98.134.186/32
    set security nat destination rule-set ESXRemoteManagement rule External-to-ESX match destination-port 42069
    set security nat destination rule-set ESXRemoteManagement rule External-to-ESX match protocol tcp
    set security nat destination rule-set ESXRemoteManagement rule External-to-ESX then destination-nat pool ESXPortForward
    set security policies from-zone Internal to-zone Internet policy All_Internal_Internet match source-address DNSOffice
    set security policies from-zone Internal to-zone Internet policy All_Internal_Internet match destination-address any
    set security policies from-zone Internal to-zone Internet policy All_Internal_Internet match application any
    set security policies from-zone Internal to-zone Internet policy All_Internal_Internet then permit
    set security policies from-zone Internal to-zone Internet policy Office-to-AD match source-address DNSOffice
    set security policies from-zone Internal to-zone Internet policy Office-to-AD match destination-address DNS-ADs
    set security policies from-zone Internal to-zone Internet policy Office-to-AD match application any
    set security policies from-zone Internal to-zone Internet policy Office-to-AD then permit
    set security policies from-zone Internal to-zone Internet policy policy_out_DNS-to-AD match source-address addr_192_168_50_0_24
    set security policies from-zone Internal to-zone Internet policy policy_out_DNS-to-AD match destination-address addr_10_200_20_81_32
    set security policies from-zone Internal to-zone Internet policy policy_out_DNS-to-AD match destination-address addr_10_200_20_80_32
    set security policies from-zone Internal to-zone Internet policy policy_out_DNS-to-AD match application any
    set security policies from-zone Internal to-zone Internet policy policy_out_DNS-to-AD then permit
    set security policies from-zone Internet to-zone Internal policy AD-to-Office match source-address DNS-ADs
    set security policies from-zone Internet to-zone Internal policy AD-to-Office match destination-address DNSOffice
    set security policies from-zone Internet to-zone Internal policy AD-to-Office match application any
    set security policies from-zone Internet to-zone Internal policy AD-to-Office then permit
    set security policies from-zone Internet to-zone Internal policy External-to-ESX match source-address any
    set security policies from-zone Internet to-zone Internal policy External-to-ESX match destination-address ESX
    set security policies from-zone Internet to-zone Internal policy External-to-ESX match application junos-https
    set security policies from-zone Internet to-zone Internal policy External-to-ESX then permit
    set security policies from-zone VoIP to-zone Internal policy VoIP-to-Tim match source-address VoIP-SubNet
    set security policies from-zone VoIP to-zone Internal policy VoIP-to-Tim match destination-address any
    set security policies from-zone VoIP to-zone Internal policy VoIP-to-Tim match application any
    set security policies from-zone VoIP to-zone Internal policy VoIP-to-Tim then permit
    set security policies from-zone Internal to-zone VoIP policy Tim-to-VoIP match source-address Tim-PC
    set security policies from-zone Internal to-zone VoIP policy Tim-to-VoIP match source-address Tim-DevBox
    set security policies from-zone Internal to-zone VoIP policy Tim-to-VoIP match source-address Tim-Phone1
    set security policies from-zone Internal to-zone VoIP policy Tim-to-VoIP match source-address Tim-CellPhone
    set security policies from-zone Internal to-zone VoIP policy Tim-to-VoIP match source-address Kyvan
    set security policies from-zone Internal to-zone VoIP policy Tim-to-VoIP match destination-address VoIP-SubNet
    set security policies from-zone Internal to-zone VoIP policy Tim-to-VoIP match application any
    set security policies from-zone Internal to-zone VoIP policy Tim-to-VoIP then permit
    set security policies from-zone Dev to-zone Internal policy Dev-to-Office match source-address Dev-SubNet
    set security policies from-zone Dev to-zone Internal policy Dev-to-Office match destination-address DNSOffice
    set security policies from-zone Dev to-zone Internal policy Dev-to-Office match application any
    set security policies from-zone Dev to-zone Internal policy Dev-to-Office then permit
    set security policies from-zone Internal to-zone Dev policy Office-to-Dev match source-address DNSOffice
    set security policies from-zone Internal to-zone Dev policy Office-to-Dev match destination-address Dev-SubNet
    set security policies from-zone Internal to-zone Dev policy Office-to-Dev match application any
    set security policies from-zone Internal to-zone Dev policy Office-to-Dev then permit
    set security policies from-zone Dev to-zone Internet policy Dev-to-Internet match source-address Dev-SubNet
    set security policies from-zone Dev to-zone Internet policy Dev-to-Internet match destination-address any
    set security policies from-zone Dev to-zone Internet policy Dev-to-Internet match application any
    set security policies from-zone Dev to-zone Internet policy Dev-to-Internet then permit
    set security policies from-zone VoIP to-zone Internet policy VoIP-to-Internet match source-address VoIP-SubNet
    set security policies from-zone VoIP to-zone Internet policy VoIP-to-Internet match destination-address any
    set security policies from-zone VoIP to-zone Internet policy VoIP-to-Internet match application any
    set security policies from-zone VoIP to-zone Internet policy VoIP-to-Internet then permit
    set security zones security-zone Internal description Office
    set security zones security-zone Internal address-book address DNSOffice 192.168.50.0/24
    set security zones security-zone Internal address-book address Tim-PC 192.168.50.75/32
    set security zones security-zone Internal address-book address Tim-DevBox 192.168.50.114/32
    set security zones security-zone Internal address-book address Tim-Phone1 192.168.50.102/32
    set security zones security-zone Internal address-book address Kyvan 192.168.50.52/32
    set security zones security-zone Internal address-book address Tim-CellPhone 192.168.50.59/32
    set security zones security-zone Internal address-book address addr_192_168_50_0_24 192.168.50.0/24
    set security zones security-zone Internal address-book address ESX 192.168.50.211/32
    set security zones security-zone Internal host-inbound-traffic system-services ping
    set security zones security-zone Internal interfaces ge-0/0/1.0 host-inbound-traffic system-services ping
    set security zones security-zone Internal interfaces ge-0/0/1.0 host-inbound-traffic system-services dhcp
    set security zones security-zone Internal interfaces ge-0/0/1.0 host-inbound-traffic system-services http
    set security zones security-zone Internal interfaces ge-0/0/1.0 host-inbound-traffic system-services https
    set security zones security-zone Internal interfaces ge-0/0/1.0 host-inbound-traffic system-services ssh
    set security zones security-zone Internal interfaces ge-0/0/1.0 host-inbound-traffic system-services traceroute
    set security zones security-zone Internet address-book address DNS-ADs range-address 10.200.20.80 to 10.200.20.81
    set security zones security-zone Internet address-book address addr_10_200_20_81_32 10.200.20.81/32
    set security zones security-zone Internet address-book address addr_10_200_20_80_32 10.200.20.80/32
    set security zones security-zone Internet screen untrust-screen
    set security zones security-zone Internet host-inbound-traffic system-services ike
    set security zones security-zone Internet interfaces ge-0/0/0.0 host-inbound-traffic system-services ssh
    set security zones security-zone Internet interfaces ge-0/0/0.0 host-inbound-traffic system-services http
    set security zones security-zone Internet interfaces ge-0/0/0.0 host-inbound-traffic system-services https
    set security zones security-zone Internet interfaces ge-0/0/0.0 host-inbound-traffic system-services traceroute
    set security zones security-zone Internet interfaces ge-0/0/0.0 host-inbound-traffic system-services dns
    set security zones security-zone Internet interfaces ge-0/0/0.0 host-inbound-traffic system-services ping
    set security zones security-zone Internet interfaces ge-0/0/0.0 host-inbound-traffic system-services snmp
    set security zones security-zone Internet interfaces ge-0/0/0.0 host-inbound-traffic system-services ike
    set security zones security-zone Internet interfaces st0.2 host-inbound-traffic system-services all
    set security zones security-zone VoIP description VoIP
    set security zones security-zone VoIP address-book address VoIP-SubNet 192.168.75.0/24
    set security zones security-zone VoIP host-inbound-traffic system-services ping
    set security zones security-zone VoIP interfaces ge-0/0/2.0 host-inbound-traffic system-services dns
    set security zones security-zone VoIP interfaces ge-0/0/2.0 host-inbound-traffic system-services dhcp
    set security zones security-zone VoIP interfaces ge-0/0/2.0 host-inbound-traffic system-services http
    set security zones security-zone VoIP interfaces ge-0/0/2.0 host-inbound-traffic system-services https
    set security zones security-zone VoIP interfaces ge-0/0/2.0 host-inbound-traffic system-services ping
    set security zones security-zone VoIP interfaces ge-0/0/2.0 host-inbound-traffic system-services ssh
    set security zones security-zone VoIP interfaces ge-0/0/2.0 host-inbound-traffic system-services traceroute
    set security zones security-zone Dev description Dev-Environment
    set security zones security-zone Dev address-book address Dev-SubNet 192.168.100.0/24
    set security zones security-zone Dev host-inbound-traffic system-services ping
    set security zones security-zone Dev interfaces ge-0/0/3.0 host-inbound-traffic system-services traceroute
    set security zones security-zone Dev interfaces ge-0/0/3.0 host-inbound-traffic system-services dhcp
    set security zones security-zone Dev interfaces ge-0/0/3.0 host-inbound-traffic system-services dns
    set security zones security-zone Dev interfaces ge-0/0/3.0 host-inbound-traffic system-services http
    set security zones security-zone Dev interfaces ge-0/0/3.0 host-inbound-traffic system-services https
    set security zones security-zone Dev interfaces ge-0/0/3.0 host-inbound-traffic system-services ping
    set security zones security-zone Dev interfaces ge-0/0/3.0 host-inbound-traffic system-services ssh
    set security zones security-zone Dev interfaces ge-0/0/3.0 host-inbound-traffic system-services telnet
    set interfaces ge-0/0/0 speed 100m
    set interfaces ge-0/0/0 link-mode full-duplex
    set interfaces ge-0/0/0 gigether-options no-auto-negotiation
    set interfaces ge-0/0/0 unit 0 description Fibrenoire
    set interfaces ge-0/0/0 unit 0 family inet address 75.98.134.186/29
    set interfaces ge-0/0/1 unit 0 description "Office VLAN"
    set interfaces ge-0/0/1 unit 0 family inet address 192.168.50.1/24
    set interfaces ge-0/0/2 unit 0 description "VoIP Vlan"
    set interfaces ge-0/0/2 unit 0 family inet address 192.168.75.1/24
    set interfaces ge-0/0/3 unit 0 description Dev
    set interfaces ge-0/0/3 unit 0 family inet address 192.168.100.1/24
    set interfaces fxp0 unit 0 family inet address 192.168.50.1/24
    set interfaces st0 unit 2 family inet
    set snmp description DNS-Office
    set snmp location Ottawa
    set snmp contact DNSnetworks
    set snmp community 4Inform3*Involvement authorization read-only
    set routing-options static route 0.0.0.0/0 next-hop 75.98.134.185
    set routing-options static route 10.200.20.81/32 next-hop st0.2
    set routing-options static route 10.200.20.80/32 next-hop st0.2
    set class-of-service forwarding-classes queue 5 Voice-5
    set class-of-service forwarding-classes queue 6 Voice-6
    set class-of-service interfaces ge-0/0/0 scheduler-map VoiceSched
    set class-of-service interfaces ge-0/0/0 unit 0 forwarding-class Voice-5
    set class-of-service interfaces ge-0/0/1 scheduler-map VoiceSched
    set class-of-service interfaces ge-0/0/1 unit 0 forwarding-class Voice-5
    set class-of-service scheduler-maps VoiceSched forwarding-class network-control scheduler network-control-scheduler
    set class-of-service scheduler-maps VoiceSched forwarding-class Voice-6 scheduler voice6-scheduler
    set class-of-service scheduler-maps VoiceSched forwarding-class Voice-5 scheduler voice5-scheduler
    set class-of-service scheduler-maps VoiceSched forwarding-class best-effort scheduler best-effort-scheduler
    set class-of-service schedulers network-control-scheduler buffer-size percent 10
    set class-of-service schedulers network-control-scheduler priority strict-high
    set class-of-service schedulers voice6-scheduler buffer-size percent 10
    set class-of-service schedulers voice6-scheduler priority high
    set class-of-service schedulers voice5-scheduler buffer-size percent 10
    set class-of-service schedulers voice5-scheduler priority medium-high
    set class-of-service schedulers best-effort-scheduler transmit-rate remainder
    set class-of-service schedulers best-effort-scheduler buffer-size remainder
    set class-of-service schedulers best-effort-scheduler priority low