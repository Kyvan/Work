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
            if [[ "$ENTITY" = "org_name" ]] || [[ "$ENTITY" = "domain" ]] || [[ "$ENTITY" = "dkim" ]] || [[ "$ENTITY" = "spf" ]] || [[ "$ENTITY" = "source_ip" ]] ; then
                echo "$ENTITY => $CONTENT"
            fi
        done < "$xmlReports" >> ../dmarcReport-"$(date +%F)".txt
    done
    
    find . -maxdepth 1 -type f -exec rm -f {} \;

    echo "Report is ready"
}

function failedDMARCReports() {
    archiveDir="c:\users\kyvan\OneDrive - dnsnetworks.ca\DMARC"
    cd "$archiveDir" || exit

    find . -maxdepth 1 -daystart -mtime -1 -type f -exec grep -B5 -i fail {} \; > dmarcFailedReports/dmarcFailedReport-"$(date +%F)".txt
    echo "Report is ready"
}

echo "What function of the script are you looking to use?"
echo "1. Generate XML files from reports"
echo "2. Generate DMARC report based on XML files"
echo "3. Generate Failed DMARC report only"
echo "4. Generate XML and DMARC, and failed DMARC reports"
read -rp "Option: " option

case "$option" in
    4)
        echo "Generating both XML and DMARC reports" && xmlExtracting && dmarcReport && failedDMARCReports
        ;;
    3)
        echo "Generating failed DMARC reports" && failedDMARCReports
        ;;
    2)
        echo "Generating the DMARC Reprot" && dmarcReport
        ;;
    1)
        echo "Unziping to generate the XML reports" && xmlExtracting
        ;;
    *)
        echo "No action needed, exiting the script"
        ;;
esac