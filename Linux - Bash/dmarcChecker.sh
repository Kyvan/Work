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

    # find command to delete Zip and Gzip reports
    find . -maxdepth 1 -type f | grep -E '(zip|gz)' | xargs rm -f

    # find command to move the XML reports to a different directory
    find . -maxdepth 1 -type f | grep -v "txt" | xargs -I {} mv {} dmarcXML/

    echo "XML files are ready"
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

    echo "DMARC report is ready"
}

function failedDMARCReports() {
    archiveDir="c:\users\kyvan\OneDrive - dnsnetworks.ca\DMARC\dmarcReports"
    cd "$archiveDir" || exit

    find . -maxdepth 1 -daystart -mtime -1 -type f -exec grep -B5 -i fail {} \; >> ../dmarcFailedReports/dmarcFailedReport-"$(date +%F)".txt
    echo "Failed DMARC report is ready"
}

function domainReports() {
    archiveDir="c:\users\kyvan\OneDrive - dnsnetworks.ca\DMARC\dmarcFailedReports"
    cd "$archiveDir" || exit
    
    while read -r domains ; do
        find . -maxdepth 1 -daystart -mtime -1 -type f -exec grep -A1 -i "$domains" {} \; > "$domains\\${domains}.txt"
        echo "$domains Report is ready"
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
    case "${option,,}" in
        --help | -h | help | h)
            options
            ;;
        all)
            echo "Generating ALL the reports" && xmlExtracting && dmarcReport && domainReports && failedDMARCReports
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
    echo "XML: Generate XML files from reports"
    echo "Report: Generate DMARC report based on XML files"
    echo "Failed: Generate Failed DMARC report only"
    echo "Dreport: Generate domain specific Failed DMARC report"
    echo "All: Generate XML and DMARC, and failed DMARC reports"
    read -rp "Which of the above options are you looking to use? $(echo -e '\n> ')" option

    chosenOption "$option"
}

if test "$#" -eq "0" ; then
    menu
elif test "$#" -eq "1" ; then
    option="$1"
    chosenOption "$option"
else
    echo "For more help, please run $0 --help"
    echo "ERROR: You need either 1 or zero option for the script"
    echo "USAGE: $0 [argument]"
fi