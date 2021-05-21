#!/bin/bash -u

for (( i = 1 ; i <8 ; i++ )) ; do
    echo "set security policies from-zone DNS_NET1 to-zone BGP_GROUP_EX policy VLAN128-Internet-Allow match source-address any"
    echo "set security policies from-zone DNS_NET1 to-zone BGP_GROUP_EX policy VLAN128-Internet-Allow match destination-address any"
    echo "set security policies from-zone DNS_NET1 to-zone BGP_GROUP_EX policy VLAN128-Internet-Allow match application [ junos-dns-udp junos-ftp junos-http junos-http-ext junos-https junos-icmp-ping junos-ping TCP-8080 junos-imap junos-imaps junos-smtp junos-pop3 SMTPs1 SMTPs2 HTTP-8443 junos-ntp TCP-5721 UDP-5721 ]"
    echo "set security policies from-zone DNS_NET1 to-zone BGP_GROUP_EX policy VLAN128-Internet-Allow then permit"
done