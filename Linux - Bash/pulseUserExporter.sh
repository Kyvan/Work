#!/bin/bash -u

function xmlParser() {

    local IFS=\>
    read -rd \< ENTITY CONTENT
}

function userExporter() {
    xmlDir="c:\users\kyvan\OneDrive - dnsnetworks.ca\XML\Users"
    cd "$xmlDir" || exit
    
    for xmlReports in * ; do
        while xmlParser ; do
            if [ "$ENTITY" = "username" ] || [ "$ENTITY" = "fullname" ] || [ "$ENTITY" = "enabled" ] ; then
                echo "$ENTITY => $CONTENT"
            fi
        done < "$xmlReports" > ../exportedUsers\\"$xmlReports".txt
        echo -e "\e[34mVPN user list for $xmlReports is ready."
    done    
}

function enabledVPNUsers() {
    exportedDir="c:\users\kyvan\OneDrive - dnsnetworks.ca\XML\exportedUsers"
    cd "$exportedDir" || exit

    find . -maxdepth 1 -daystart -mtime -1 -type f -exec grep -B2 -i true {} \; > ../Enabled/enabledVPNUsers-"$(date +%F)".txt
    echo -e "\e[35mEnabled VPN Users are ready."
}

function countVPNUsers() {
    enabledDir="c:\users\kyvan\OneDrive - dnsnetworks.ca\XML\Enabled"
    cd "$enabledDir" || exit

    grep -i fullname enabledVPNUsers* | awk '{ print $NF }' | sort | uniq -c > ../Counted/countedVPNUsers-"$(date +%F)".txt
    echo -e "\e[36mCount of VPN Users is ready."
}

function options() {
    echo "These are the options that can be used with this script (only one option at a time)"
    echo "PureColo: Export Users for PureColo VPN appliance"
    echo "Rogers: Export Users for Rogers/Miami VPN appliance"
    echo "Montreal: Export Users for Montreal VPN appliance"
    echo "Count: Count number of VPN accounts per customer"
    echo "All: Export Users for all VPN appliances"
}

function chosenOption() {
    case "${1,,}" in
        --help | -h | help | h)
            options
            ;;
        all)
            echo "Generating ALL VPN Users" && userExporter && enabledVPNUsers && countVPNUsers #Montreal.xml && userExporter PureColo.xml && userExporter Rogers.xml && enabledVPNUsers
            ;;
        count)
            echo "Generating counted VPN account report" && countVPNUsers
            ;;
        purecolo)
            echo "Generating PureColo VPN Users" && userExporter PureColo.xml
            ;;
        rogers)
            echo "Generating Rogers/Miami VPN Users" && userExporter Rogers.xml
            ;;
        montreal)
            echo "Generating Montreal VPN Users" && userExporter Montreal.xml
            ;;
        *)
            echo "If you need to know the options, please run the script with --help"
            ;;
    esac
}

function menu() {
    options
    read -rp "Which of the above options are you looking to use? $(echo -e '\n> ')" answer
    chosenOption "$answer"
}

if test "$#" -eq "0" ; then
    menu
elif test "$#" -eq "1" ; then
    chosenOption "$1"
else
    echo "ERROR: You need either 1 or zero option for the script"
    echo "USAGE: $0 [argument]"
    echo
    options
fi