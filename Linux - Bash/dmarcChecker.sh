#!/bin/bash -u

function unZip() {
    archiveDir="~\OneDrive - dnsnetworks.ca\DMARC"
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
    find "$archiveDir" -maxdepth 1 -type f | grep -E '(zip|gz)' | xargs rm -f

    # find command to move the XML reports to a different directory
    find "$archiveDir" -maxdepth 1 -type f | grep -v "txt" | xargs -I {} mv {} dmarcXML/

    echo "XML files are ready"
}

function xmlParser() {

    local IFS=\>
    read -rd \< ENTITY CONTENT
}

function dmarcReport() {
    xmlDir="~\OneDrive - dnsnetworks.ca\DMARC\dmarcXML"
    cd "$xmlDir" || exit
    
    for xmlReports in * ; do
        while xmlParser ; do
            if [[ "$ENTITY" = "org_name" ]] || [[ "$ENTITY" = "domain" ]] || [[ "$ENTITY" = "dkim" ]] || [[ "$ENTITY" = "spf" ]] || [[ "$ENTITY" = "source_ip" ]] ; then
                echo "$ENTITY => $CONTENT"
            fi
        done < "$xmlReports" >> ../dmarcReport.txt
    done
    echo "Report is ready"
}

echo "What function of the script are you looking to use?"
echo "1. Generate XML files from reports"
echo "2. Generate dmarc report based on XML files"
read -rp "Option: " option

case "$option" in
    2)
        echo "Generating the dmarc Reprot" && dmarcReport
        ;;
    1)
        echo "Unziping to generate the XML reports" && unZip
        ;;
    *)
        echo "No action needed, exiting the script"
        ;;
esac