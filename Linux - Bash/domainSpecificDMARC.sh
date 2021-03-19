#!/bin/bash -ux

function domainReports() {
    archiveDir="c:\users\kyvan\OneDrive - dnsnetworks.ca\DMARC\dmarcFailedReports"
    cd "$archiveDir" || exit
    
    find . -maxdepth 1 -daystart -mtime -1 -type f -exec grep -A1 -i "$1" {} \; > "$1\\${1}.txt"
    echo "Report is ready"
}

while read -r domains ; do
    domainReports "$domains"
done < domain.txt