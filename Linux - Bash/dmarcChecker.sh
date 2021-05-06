#!/bin/bash -u

function xmlExtracting() {
    archiveDir="c:\users\kyvan\OneDrive - dnsnetworks.ca\DMARC"
    cd "$archiveDir" || exit

    # Loop to unzip Gzip and Zip reports
    for reports in * ; do
        if file "$reports" | grep gzip ; then
            gunzip "$reports"
        elif file "$reports" | grep Zip ; then
            unzip "$reports"
        fi
    done

    find . -maxdepth 1 -type f | grep -E '(zip|gz)' | xargs rm -f
    find . -maxdepth 1 -type f | grep -v "txt" | xargs -I {} mv {} dmarcXML/

    echo -e "\e[33mXML files are ready."
}

function xmlParser() {

    local IFS=\>
    read -rd \< ENTITY CONTENT
}

function dmarcReport() {
    xmlDir="c:\users\kyvan\OneDrive - dnsnetworks.ca\DMARC\dmarcXML"
    cd "$xmlDir" || exit
    
    for xmlReports in * ; do
        while xmlParser ; do
            if [ "$ENTITY" = "org_name" ] || [ "$ENTITY" = "domain" ] || [ "$ENTITY" = "dkim" ] || [ "$ENTITY" = "spf" ] || [ "$ENTITY" = "source_ip" ] ; then
                echo "$ENTITY => $CONTENT"
            fi
        done < "$xmlReports" >> ../dmarcReports/dmarcReport-"$(date +%F)".txt
    done
    
    find . -maxdepth 1 -type f -exec rm -f {} \;

    echo -e "\e[34mDMARC report is ready."
}

function failedDMARCReports() {
    archiveDir="c:\users\kyvan\OneDrive - dnsnetworks.ca\DMARC\dmarcReports"
    cd "$archiveDir" || exit

    find . -maxdepth 1 -daystart -mtime -1 -type f -exec grep -B4 -i fail {} \; >> ../dmarcFailedReports/dmarcFailedReport-"$(date +%F)".txt
    echo -e "\e[35mFailed DMARC report is ready."
}

function domainReports() {
    archiveDir="c:\users\kyvan\OneDrive - dnsnetworks.ca\DMARC\dmarcFailedReports"
    cd "$archiveDir" || exit
    
    while read -r domains ; do
        mkdir "$domains"
        find . -maxdepth 1 -daystart -mtime -1 -type f -exec grep -A1 -i "$domains" {} \; > "$domains\\${domains}.txt"
        echo -e "\e[36m$domains Report is ready."
    done < "c:\\users\\kyvan\\onedrive\\Documents\\git\\Work\\Linux - Bash\\domain.txt"
}

function options() {
    echo "These are the options that can be used with this script (only one option at a time)"
    echo "XML: Generate XML files from reports"
    echo "Report: Generate DMARC report based on XML files"
    echo "Failed: Generate Failed DMARC report only"
    echo "Dreport: Generate domain specific Failed DMARC report"
    echo "All: Generate XML, DMARC, and failed DMARC reports"
}

function chosenOption() {
    case "${1,,}" in
        --help | -h | help | h)
            options
            ;;
        all)
            echo "Generating ALL the reports" && xmlExtracting && dmarcReport && failedDMARCReports && domainReports
            ;;
        dreport)
            echo "Generating domain specific failed reports" && domainReports
            ;;
        failed)
            echo "Generating failed DMARC reports" && failedDMARCReports
            ;;
        report)
            echo "Generating the DMARC Reprot" && dmarcReport
            ;;
        xml)
            echo "Unziping to generate the XML reports" && xmlExtracting
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