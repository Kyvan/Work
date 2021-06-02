#!/bin/bash -u
    read -p "What's the hostname? " hostName
    read -p "What's the Primary DNS? " DNS1
    read -p "What's the Secondaty DNS? " DNS2
    
    echo "set system host-name $hostName" >> template.txt
    echo "set system time-zone EST" >> template.txt
    echo "set system root-authentication encrypted-password \"$5$YeRRXRzL$go4sISMi5K/mfuwCgAK.6ruuYMstcvIH3Ptmvng.I7D\"" >> template.txt
    echo "set system name-server $DNS1" >> template.txt
    echo "set system name-server $DNS2" >> template.txt
    echo "set system name-resolution no-resolve-on-input" >> template.txt
    echo "set system login user almond uid 2000" >> template.txt
    echo "set system login user almond class super-user" >> template.txt
    echo "set system login user almond authentication encrypted-password \"$5$wIHiGlLC$sVoW/O4FoLzn01eLhSu3R7F/mO6bCM6l8uRls/5Ma13\"" >> template.txt
    echo "set system services ssh" >> template.txt
    echo "set system services telnet" >> template.txt
    echo "set system services web-management http interface ge-0/0/1.0" >> template.txt
    echo "set system services web-management http interface ge-0/0/0.0" >> template.txt
    echo "set system services web-management https system-generated-certificate" >> template.txt
    echo "set system services web-management https interface ge-0/0/1.0" >> template.txt
    echo "set system services web-management https interface ge-0/0/0.0" >> template.txt
    echo "set system services dhcp boot-file undionly.kpxe" >> template.txt
    echo "set system services dhcp next-server 192.168.100.195" >> template.txt
    echo "set system services dhcp pool 192.168.50.0/24 address-range low 192.168.50.50" >> template.txt
    echo "set system services dhcp pool 192.168.50.0/24 address-range high 192.168.50.150" >> template.txt
    echo "set system services dhcp pool 192.168.50.0/24 domain-name dnsnetworks.local" >> template.txt
    echo "set system services dhcp pool 192.168.50.0/24 name-server 10.200.20.80" >> template.txt
    echo "set system services dhcp pool 192.168.50.0/24 name-server 1.1.1.1" >> template.txt
    echo "set system services dhcp pool 192.168.50.0/24 router 192.168.50.1" >> template.txt
    echo "set system services dhcp pool 192.168.50.0/24 server-identifier 192.168.50.1" >> template.txt
    echo "set system services dhcp pool 192.168.75.0/24 address-range low 192.168.75.50" >> template.txt
    echo "set system services dhcp pool 192.168.75.0/24 address-range high 192.168.75.200" >> template.txt
    echo "set system services dhcp pool 192.168.75.0/24 name-server 8.8.8.8" >> template.txt
    echo "set system services dhcp pool 192.168.75.0/24 name-server 8.8.4.4" >> template.txt
    echo "set system services dhcp pool 192.168.75.0/24 router 192.168.75.1" >> template.txt
    echo "set system services dhcp pool 192.168.75.0/24 server-identifier 192.168.75.1" >> template.txt
    echo "set system services dhcp pool 192.168.100.0/24 address-range low 192.168.100.50" >> template.txt
    echo "set system services dhcp pool 192.168.100.0/24 address-range high 192.168.100.200" >> template.txt
    echo "set system services dhcp pool 192.168.100.0/24 name-server 8.8.8.8" >> template.txt
    echo "set system services dhcp pool 192.168.100.0/24 name-server 8.8.4.4" >> template.txt
    echo "set system services dhcp pool 192.168.100.0/24 router 192.168.100.1" >> template.txt
    echo "set system services dhcp pool 192.168.100.0/24 server-identifier 192.168.100.1" >> template.txt
    echo "set system services dhcp static-binding a0:d3:c1:2a:d3:65 fixed-address 192.168.50.114" >> template.txt
    echo "set system services dhcp static-binding a0:d3:c1:2a:d3:65 host-name Tim-DevBox" >> template.txt
    echo "set system services dhcp static-binding ec:b1:d7:2e:30:ac fixed-address 192.168.50.75" >> template.txt
    echo "set system services dhcp static-binding ec:b1:d7:2e:30:ac host-name Tim-PC" >> template.txt
    echo "set system services dhcp static-binding f0:9f:c2:56:91:dc fixed-address 192.168.50.83" >> template.txt
    echo "set system services dhcp static-binding f0:9f:c2:56:91:dc host-name UniFi-AP" >> template.txt
    echo "set system services dhcp static-binding 00:04:f2:81:ef:fc fixed-address 192.168.50.102" >> template.txt
    echo "set system services dhcp static-binding 00:04:f2:81:ef:fc host-name Phone" >> template.txt
    echo "set system services dhcp static-binding b4:f7:a1:be:eb:c9 fixed-address 192.168.50.59" >> template.txt
    echo "set system services dhcp static-binding b4:f7:a1:be:eb:c9 host-name Tim-CellPhone" >> template.txt
    echo "set system services dhcp static-binding 8c:dc:d4:2f:d1:02 fixed-address 192.168.50.82" >> template.txt
    echo "set system services dhcp static-binding 8c:dc:d4:2f:d1:02 host-name Kyvan-PC" >> template.txt
    echo "set system services dhcp static-binding 00:0c:29:40:af:e3 fixed-address 192.168.50.111" >> template.txt
    echo "set system services dhcp static-binding 00:0c:29:40:af:e3 host-name OpenVas" >> template.txt
    echo "set system syslog archive size 100k" >> template.txt
    echo "set system syslog archive files 3" >> template.txt
    echo "set system syslog user * any emergency" >> template.txt
    echo "set system syslog file messages any critical" >> template.txt
    echo "set system syslog file messages authorization info" >> template.txt
    echo "set system syslog file interactive-commands interactive-commands error" >> template.txt
    echo "set system syslog file kmd-logs daemon info" >> template.txt
    echo "set system syslog file kmd-logs match KMD" >> template.txt
    echo "set system max-configurations-on-flash 5" >> template.txt
    echo "set system max-configuration-rollbacks 5" >> template.txt
    echo "set system license autoupdate url https://ae1.juniper.net/junos/key_retrieval" >> template.txt
    echo "set system ntp server time.nrc.ca" >> template.txt
    echo "set chassis fpc 1 pic 0 q-pic-large-buffer large-scale" >> template.txt
    echo "set security ike proposal AD-Proposal1 authentication-method pre-shared-keys" >> template.txt
    echo "set security ike proposal AD-Proposal1 dh-group group14" >> template.txt
    echo "set security ike proposal AD-Proposal1 authentication-algorithm sha-256" >> template.txt
    echo "set security ike proposal AD-Proposal1 encryption-algorithm aes-256-cbc" >> template.txt
    echo "set security ike proposal AD-Proposal1 lifetime-seconds 28800" >> template.txt
    echo "set security ike policy AD-Policy1 mode main" >> template.txt
    echo "set security ike policy AD-Policy1 proposals AD-Proposal1" >> template.txt
    echo "set security ike policy AD-Policy1 pre-shared-key ascii-text \"$9$tnuHuEcleM-VYlKoGUjf5IEcyrvdVYZUH24ZDHkQzIEcSK87-V\"" >> template.txt
    echo "set security ike gateway AD-Gateway ike-policy AD-Policy1" >> template.txt
    echo "set security ike gateway AD-Gateway address 75.98.140.12" >> template.txt
    echo "set security ike gateway AD-Gateway external-interface ge-0/0/0.0" >> template.txt
    echo "set security ike gateway AD-Gateway version v1-only" >> template.txt
    echo "set security ipsec traceoptions flag all" >> template.txt
    echo "set security ipsec proposal AD-Porposal2 protocol esp" >> template.txt
    echo "set security ipsec proposal AD-Porposal2 authentication-algorithm hmac-sha-256-128" >> template.txt
    echo "set security ipsec proposal AD-Porposal2 encryption-algorithm aes-256-cbc" >> template.txt
    echo "set security ipsec proposal AD-Porposal2 lifetime-seconds 3600" >> template.txt
    echo "set security ipsec policy AD-Policy2 perfect-forward-secrecy keys group14" >> template.txt
    echo "set security ipsec policy AD-Policy2 proposals AD-Porposal2" >> template.txt
    echo "set security ipsec vpn AD-VPN bind-interface st0.2" >> template.txt
    echo "set security ipsec vpn AD-VPN ike gateway AD-Gateway" >> template.txt
    echo "set security ipsec vpn AD-VPN ike ipsec-policy AD-Policy2" >> template.txt
    echo "set security ipsec vpn AD-VPN establish-tunnels immediately" >> template.txt
    echo "set security screen ids-option untrust-screen icmp ping-death" >> template.txt
    echo "set security screen ids-option untrust-screen ip source-route-option" >> template.txt
    echo "set security screen ids-option untrust-screen ip tear-drop" >> template.txt
    echo "set security screen ids-option untrust-screen tcp syn-flood alarm-threshold 1024" >> template.txt
    echo "set security screen ids-option untrust-screen tcp syn-flood attack-threshold 200" >> template.txt
    echo "set security screen ids-option untrust-screen tcp syn-flood source-threshold 1024" >> template.txt
    echo "set security screen ids-option untrust-screen tcp syn-flood destination-threshold 2048" >> template.txt
    echo "set security screen ids-option untrust-screen tcp syn-flood timeout 20" >> template.txt
    echo "set security screen ids-option untrust-screen tcp land" >> template.txt
    echo "set security nat source pool Fibrenoir-Pool address 75.98.134.186/32" >> template.txt
    echo "set security nat source rule-echo "set nsw_srcnat from zone Dev" >> template.txt
    echo "set security nat source rule-echo "set nsw_srcnat from zone Internal" >> template.txt
    echo "set security nat source rule-echo "set nsw_srcnat from zone VoIP" >> template.txt
    echo "set security nat source rule-echo "set nsw_srcnat to zone Internet" >> template.txt
    echo "set security nat source rule-echo "set nsw_srcnat rule DNSOffice-to-DNSAD match source-address 192.168.50.0/24" >> template.txt
    echo "set security nat source rule-echo "set nsw_srcnat rule DNSOffice-to-DNSAD match source-address 192.168.75.0/24" >> template.txt
    echo "set security nat source rule-echo "set nsw_srcnat rule DNSOffice-to-DNSAD match source-address 192.168.100.0/24" >> template.txt
    echo "set security nat source rule-echo "set nsw_srcnat rule DNSOffice-to-DNSAD match destination-address 10.200.20.80/32" >> template.txt
    echo "set security nat source rule-echo "set nsw_srcnat rule DNSOffice-to-DNSAD match destination-address 10.200.20.81/32" >> template.txt
    echo "set security nat source rule-echo "set nsw_srcnat rule DNSOffice-to-DNSAD match protocol tcp" >> template.txt
    echo "set security nat source rule-echo "set nsw_srcnat rule DNSOffice-to-DNSAD match protocol udp" >> template.txt
    echo "set security nat source rule-echo "set nsw_srcnat rule DNSOffice-to-DNSAD then source-nat off" >> template.txt
    echo "set security nat source rule-echo "set nsw_srcnat rule nsw-src-interface match source-address 192.168.0.0/16" >> template.txt
    echo "set security nat source rule-echo "set nsw_srcnat rule nsw-src-interface match destination-address 0.0.0.0/0" >> template.txt
    echo "set security nat source rule-echo "set nsw_srcnat rule nsw-src-interface match protocol tcp" >> template.txt
    echo "set security nat source rule-echo "set nsw_srcnat rule nsw-src-interface match protocol udp" >> template.txt
    echo "set security nat source rule-echo "set nsw_srcnat rule nsw-src-interface then source-nat pool Fibrenoir-Pool" >> template.txt
    echo "set security nat destination pool ESXPortForward address 192.168.50.211/32" >> template.txt
    echo "set security nat destination pool ESXPortForward address port 443" >> template.txt
    echo "set security nat destination rule-echo "set ESXRemoteManagement from zone Internet" >> template.txt
    echo "set security nat destination rule-echo "set ESXRemoteManagement rule External-to-ESX match source-address 0.0.0.0/0" >> template.txt
    echo "set security nat destination rule-echo "set ESXRemoteManagement rule External-to-ESX match destination-address 75.98.134.186/32" >> template.txt
    echo "set security nat destination rule-echo "set ESXRemoteManagement rule External-to-ESX match destination-port 42069" >> template.txt
    echo "set security nat destination rule-echo "set ESXRemoteManagement rule External-to-ESX match protocol tcp" >> template.txt
    echo "set security nat destination rule-echo "set ESXRemoteManagement rule External-to-ESX then destination-nat pool ESXPortForward" >> template.txt
    echo "set security policies from-zone Internal to-zone Internet policy All_Internal_Internet match source-address DNSOffice" >> template.txt
    echo "set security policies from-zone Internal to-zone Internet policy All_Internal_Internet match destination-address any" >> template.txt
    echo "set security policies from-zone Internal to-zone Internet policy All_Internal_Internet match application any" >> template.txt
    echo "set security policies from-zone Internal to-zone Internet policy All_Internal_Internet then permit" >> template.txt
    echo "set security policies from-zone Internal to-zone Internet policy Office-to-AD match source-address DNSOffice" >> template.txt
    echo "set security policies from-zone Internal to-zone Internet policy Office-to-AD match destination-address DNS-ADs" >> template.txt
    echo "set security policies from-zone Internal to-zone Internet policy Office-to-AD match application any" >> template.txt
    echo "set security policies from-zone Internal to-zone Internet policy Office-to-AD then permit" >> template.txt
    echo "set security policies from-zone Internal to-zone Internet policy policy_out_DNS-to-AD match source-address addr_192_168_50_0_24" >> template.txt
    echo "set security policies from-zone Internal to-zone Internet policy policy_out_DNS-to-AD match destination-address addr_10_200_20_81_32" >> template.txt
    echo "set security policies from-zone Internal to-zone Internet policy policy_out_DNS-to-AD match destination-address addr_10_200_20_80_32" >> template.txt
    echo "set security policies from-zone Internal to-zone Internet policy policy_out_DNS-to-AD match application any" >> template.txt
    echo "set security policies from-zone Internal to-zone Internet policy policy_out_DNS-to-AD then permit" >> template.txt
    echo "set security policies from-zone Internet to-zone Internal policy AD-to-Office match source-address DNS-ADs" >> template.txt
    echo "set security policies from-zone Internet to-zone Internal policy AD-to-Office match destination-address DNSOffice" >> template.txt
    echo "set security policies from-zone Internet to-zone Internal policy AD-to-Office match application any" >> template.txt
    echo "set security policies from-zone Internet to-zone Internal policy AD-to-Office then permit" >> template.txt
    echo "set security policies from-zone Internet to-zone Internal policy External-to-ESX match source-address any" >> template.txt
    echo "set security policies from-zone Internet to-zone Internal policy External-to-ESX match destination-address ESX" >> template.txt
    echo "set security policies from-zone Internet to-zone Internal policy External-to-ESX match application junos-https" >> template.txt
    echo "set security policies from-zone Internet to-zone Internal policy External-to-ESX then permit" >> template.txt
    echo "set security policies from-zone VoIP to-zone Internal policy VoIP-to-Tim match source-address VoIP-SubNet" >> template.txt
    echo "set security policies from-zone VoIP to-zone Internal policy VoIP-to-Tim match destination-address any" >> template.txt
    echo "set security policies from-zone VoIP to-zone Internal policy VoIP-to-Tim match application any" >> template.txt
    echo "set security policies from-zone VoIP to-zone Internal policy VoIP-to-Tim then permit" >> template.txt
    echo "set security policies from-zone Internal to-zone VoIP policy Tim-to-VoIP match source-address Tim-PC" >> template.txt
    echo "set security policies from-zone Internal to-zone VoIP policy Tim-to-VoIP match source-address Tim-DevBox" >> template.txt
    echo "set security policies from-zone Internal to-zone VoIP policy Tim-to-VoIP match source-address Tim-Phone1" >> template.txt
    echo "set security policies from-zone Internal to-zone VoIP policy Tim-to-VoIP match source-address Tim-CellPhone" >> template.txt
    echo "set security policies from-zone Internal to-zone VoIP policy Tim-to-VoIP match source-address Kyvan" >> template.txt
    echo "set security policies from-zone Internal to-zone VoIP policy Tim-to-VoIP match destination-address VoIP-SubNet" >> template.txt
    echo "set security policies from-zone Internal to-zone VoIP policy Tim-to-VoIP match application any" >> template.txt
    echo "set security policies from-zone Internal to-zone VoIP policy Tim-to-VoIP then permit" >> template.txt
    echo "set security policies from-zone Dev to-zone Internal policy Dev-to-Office match source-address Dev-SubNet" >> template.txt
    echo "set security policies from-zone Dev to-zone Internal policy Dev-to-Office match destination-address DNSOffice" >> template.txt
    echo "set security policies from-zone Dev to-zone Internal policy Dev-to-Office match application any" >> template.txt
    echo "set security policies from-zone Dev to-zone Internal policy Dev-to-Office then permit" >> template.txt
    echo "set security policies from-zone Internal to-zone Dev policy Office-to-Dev match source-address DNSOffice" >> template.txt
    echo "set security policies from-zone Internal to-zone Dev policy Office-to-Dev match destination-address Dev-SubNet" >> template.txt
    echo "set security policies from-zone Internal to-zone Dev policy Office-to-Dev match application any" >> template.txt
    echo "set security policies from-zone Internal to-zone Dev policy Office-to-Dev then permit" >> template.txt
    echo "set security policies from-zone Dev to-zone Internet policy Dev-to-Internet match source-address Dev-SubNet" >> template.txt
    echo "set security policies from-zone Dev to-zone Internet policy Dev-to-Internet match destination-address any" >> template.txt
    echo "set security policies from-zone Dev to-zone Internet policy Dev-to-Internet match application any" >> template.txt
    echo "set security policies from-zone Dev to-zone Internet policy Dev-to-Internet then permit" >> template.txt
    echo "set security policies from-zone VoIP to-zone Internet policy VoIP-to-Internet match source-address VoIP-SubNet" >> template.txt
    echo "set security policies from-zone VoIP to-zone Internet policy VoIP-to-Internet match destination-address any" >> template.txt
    echo "set security policies from-zone VoIP to-zone Internet policy VoIP-to-Internet match application any" >> template.txt
    echo "set security policies from-zone VoIP to-zone Internet policy VoIP-to-Internet then permit" >> template.txt
    echo "set security zones security-zone Internal description Office" >> template.txt
    echo "set security zones security-zone Internal address-book address DNSOffice 192.168.50.0/24" >> template.txt
    echo "set security zones security-zone Internal address-book address Tim-PC 192.168.50.75/32" >> template.txt
    echo "set security zones security-zone Internal address-book address Tim-DevBox 192.168.50.114/32" >> template.txt
    echo "set security zones security-zone Internal address-book address Tim-Phone1 192.168.50.102/32" >> template.txt
    echo "set security zones security-zone Internal address-book address Kyvan 192.168.50.52/32" >> template.txt
    echo "set security zones security-zone Internal address-book address Tim-CellPhone 192.168.50.59/32" >> template.txt
    echo "set security zones security-zone Internal address-book address addr_192_168_50_0_24 192.168.50.0/24" >> template.txt
    echo "set security zones security-zone Internal address-book address ESX 192.168.50.211/32" >> template.txt
    echo "set security zones security-zone Internal host-inbound-traffic system-services ping" >> template.txt
    echo "set security zones security-zone Internal interfaces ge-0/0/1.0 host-inbound-traffic system-services ping" >> template.txt
    echo "set security zones security-zone Internal interfaces ge-0/0/1.0 host-inbound-traffic system-services dhcp" >> template.txt
    echo "set security zones security-zone Internal interfaces ge-0/0/1.0 host-inbound-traffic system-services http" >> template.txt
    echo "set security zones security-zone Internal interfaces ge-0/0/1.0 host-inbound-traffic system-services https" >> template.txt
    echo "set security zones security-zone Internal interfaces ge-0/0/1.0 host-inbound-traffic system-services ssh" >> template.txt
    echo "set security zones security-zone Internal interfaces ge-0/0/1.0 host-inbound-traffic system-services traceroute" >> template.txt
    echo "set security zones security-zone Internet address-book address DNS-ADs range-address 10.200.20.80 to 10.200.20.81" >> template.txt
    echo "set security zones security-zone Internet address-book address addr_10_200_20_81_32 10.200.20.81/32" >> template.txt
    echo "set security zones security-zone Internet address-book address addr_10_200_20_80_32 10.200.20.80/32" >> template.txt
    echo "set security zones security-zone Internet screen untrust-screen" >> template.txt
    echo "set security zones security-zone Internet host-inbound-traffic system-services ike" >> template.txt
    echo "set security zones security-zone Internet interfaces ge-0/0/0.0 host-inbound-traffic system-services ssh" >> template.txt
    echo "set security zones security-zone Internet interfaces ge-0/0/0.0 host-inbound-traffic system-services http" >> template.txt
    echo "set security zones security-zone Internet interfaces ge-0/0/0.0 host-inbound-traffic system-services https" >> template.txt
    echo "set security zones security-zone Internet interfaces ge-0/0/0.0 host-inbound-traffic system-services traceroute" >> template.txt
    echo "set security zones security-zone Internet interfaces ge-0/0/0.0 host-inbound-traffic system-services dns" >> template.txt
    echo "set security zones security-zone Internet interfaces ge-0/0/0.0 host-inbound-traffic system-services ping" >> template.txt
    echo "set security zones security-zone Internet interfaces ge-0/0/0.0 host-inbound-traffic system-services snmp" >> template.txt
    echo "set security zones security-zone Internet interfaces ge-0/0/0.0 host-inbound-traffic system-services ike" >> template.txt
    echo "set security zones security-zone Internet interfaces st0.2 host-inbound-traffic system-services all" >> template.txt
    echo "set security zones security-zone VoIP description VoIP" >> template.txt
    echo "set security zones security-zone VoIP address-book address VoIP-SubNet 192.168.75.0/24" >> template.txt
    echo "set security zones security-zone VoIP host-inbound-traffic system-services ping" >> template.txt
    echo "set security zones security-zone VoIP interfaces ge-0/0/2.0 host-inbound-traffic system-services dns" >> template.txt
    echo "set security zones security-zone VoIP interfaces ge-0/0/2.0 host-inbound-traffic system-services dhcp" >> template.txt
    echo "set security zones security-zone VoIP interfaces ge-0/0/2.0 host-inbound-traffic system-services http" >> template.txt
    echo "set security zones security-zone VoIP interfaces ge-0/0/2.0 host-inbound-traffic system-services https" >> template.txt
    echo "set security zones security-zone VoIP interfaces ge-0/0/2.0 host-inbound-traffic system-services ping" >> template.txt
    echo "set security zones security-zone VoIP interfaces ge-0/0/2.0 host-inbound-traffic system-services ssh" >> template.txt
    echo "set security zones security-zone VoIP interfaces ge-0/0/2.0 host-inbound-traffic system-services traceroute" >> template.txt
    echo "set security zones security-zone Dev description Dev-Environment" >> template.txt
    echo "set security zones security-zone Dev address-book address Dev-SubNet 192.168.100.0/24" >> template.txt
    echo "set security zones security-zone Dev host-inbound-traffic system-services ping" >> template.txt
    echo "set security zones security-zone Dev interfaces ge-0/0/3.0 host-inbound-traffic system-services traceroute" >> template.txt
    echo "set security zones security-zone Dev interfaces ge-0/0/3.0 host-inbound-traffic system-services dhcp" >> template.txt
    echo "set security zones security-zone Dev interfaces ge-0/0/3.0 host-inbound-traffic system-services dns" >> template.txt
    echo "set security zones security-zone Dev interfaces ge-0/0/3.0 host-inbound-traffic system-services http" >> template.txt
    echo "set security zones security-zone Dev interfaces ge-0/0/3.0 host-inbound-traffic system-services https" >> template.txt
    echo "set security zones security-zone Dev interfaces ge-0/0/3.0 host-inbound-traffic system-services ping" >> template.txt
    echo "set security zones security-zone Dev interfaces ge-0/0/3.0 host-inbound-traffic system-services ssh" >> template.txt
    echo "set security zones security-zone Dev interfaces ge-0/0/3.0 host-inbound-traffic system-services telnet" >> template.txt
    echo "set interfaces ge-0/0/0 speed 100m" >> template.txt
    echo "set interfaces ge-0/0/0 link-mode full-duplex" >> template.txt
    echo "set interfaces ge-0/0/0 gigether-options no-auto-negotiation" >> template.txt
    echo "set interfaces ge-0/0/0 unit 0 description Fibrenoire" >> template.txt
    echo "set interfaces ge-0/0/0 unit 0 family inet address 75.98.134.186/29" >> template.txt
    echo "set interfaces ge-0/0/1 unit 0 description \"Office VLAN\"" >> template.txt
    echo "set interfaces ge-0/0/1 unit 0 family inet address 192.168.50.1/24" >> template.txt
    echo "set interfaces ge-0/0/2 unit 0 description \"VoIP Vlan\"" >> template.txt
    echo "set interfaces ge-0/0/2 unit 0 family inet address 192.168.75.1/24" >> template.txt
    echo "set interfaces ge-0/0/3 unit 0 description Dev" >> template.txt
    echo "set interfaces ge-0/0/3 unit 0 family inet address 192.168.100.1/24" >> template.txt
    echo "set interfaces fxp0 unit 0 family inet address 192.168.50.1/24" >> template.txt
    echo "set interfaces st0 unit 2 family inet" >> template.txt
    echo "set snmp description DNS-Office" >> template.txt
    echo "set snmp location Ottawa" >> template.txt
    echo "set snmp contact DNSnetworks" >> template.txt
    echo "set snmp community 4Inform3*Involvement authorization read-only" >> template.txt
    echo "set routing-options static route 0.0.0.0/0 next-hop 75.98.134.185" >> template.txt
    echo "set routing-options static route 10.200.20.81/32 next-hop st0.2" >> template.txt
    echo "set routing-options static route 10.200.20.80/32 next-hop st0.2" >> template.txt
    echo "set class-of-service forwarding-classes queue 5 Voice-5" >> template.txt
    echo "set class-of-service forwarding-classes queue 6 Voice-6" >> template.txt
    echo "set class-of-service interfaces ge-0/0/0 scheduler-map VoiceSched" >> template.txt
    echo "set class-of-service interfaces ge-0/0/0 unit 0 forwarding-class Voice-5" >> template.txt
    echo "set class-of-service interfaces ge-0/0/1 scheduler-map VoiceSched" >> template.txt
    echo "set class-of-service interfaces ge-0/0/1 unit 0 forwarding-class Voice-5" >> template.txt
    echo "set class-of-service scheduler-maps VoiceSched forwarding-class network-control scheduler network-control-scheduler" >> template.txt
    echo "set class-of-service scheduler-maps VoiceSched forwarding-class Voice-6 scheduler voice6-scheduler" >> template.txt
    echo "set class-of-service scheduler-maps VoiceSched forwarding-class Voice-5 scheduler voice5-scheduler" >> template.txt
    echo "set class-of-service scheduler-maps VoiceSched forwarding-class best-effort scheduler best-effort-scheduler" >> template.txt
    echo "set class-of-service schedulers network-control-scheduler buffer-size percent 10" >> template.txt
    echo "set class-of-service schedulers network-control-scheduler priority strict-high" >> template.txt
    echo "set class-of-service schedulers voice6-scheduler buffer-size percent 10" >> template.txt
    echo "set class-of-service schedulers voice6-scheduler priority high" >> template.txt
    echo "set class-of-service schedulers voice5-scheduler buffer-size percent 10" >> template.txt
    echo "set class-of-service schedulers voice5-scheduler priority medium-high" >> template.txt
    echo "set class-of-service schedulers best-effort-scheduler transmit-rate remainder" >> template.txt
    echo "set class-of-service schedulers best-effort-scheduler buffer-size remainder" >> template.txt
    echo "set class-of-service schedulers best-effort-scheduler priority low" >> template.txt