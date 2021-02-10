#!/bin/bash -u

read -rp "How many rules do you need to add? " ruleNumbers

# Setting up the rules
for (( i = 0 ; i < "$ruleNumbers" ; i++ )); do
    # Asking for Port numbers and protocols
    read -rp "What's the port number you need to allow? " portNum
    read -rp "Is it TCP or UDP? " portProto
    if [ "${portProto,,}" == "tcp" ] || [ "${portProto,,}" == "t" ] ; then
        firewall-cmd --permanent --add-port="$portNum"/tcp
    elif [ "${portProto,,}" == "udp" ] || [ "${portProto,,}" == "u" ] ; then
        firewall-cmd --permanent --add-port="$portNum"/udp
    else
        echo "That is not a valid Protocol, please choose between TCP or UDP only"
        exit 1
    fi
done