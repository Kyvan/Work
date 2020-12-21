#!/bin/bash -u

read -p "How many rules do you need to add? " ruleNumbers

# Setting up the rules
for (( i = 0 ; i < $ruleNumbers ; i++ )); do
    # Asking for Port numbers and Protocols
    read -p "What's the port number you need to allow? " portNum
    read -p "Is it TCP or UDP? " portProto
    if [ ${portProto,,} == "tcp" || ${portProto,,} == "t" ] ; then
        firewall-cmd --permanent --add-port=$portNum/tcp
    elif [ ${portProto,,} == "udp" || ${portProto,,} == "u" ] ; then
        firewall-cmd --permanent --add-port=$portNum/udp
    else
        echo "That is not a valid Protocol, please choose between TCP or UDP only"
        exit 1
    fi
done