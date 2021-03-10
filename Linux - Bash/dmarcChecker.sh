#!/bin/bash -u

remoteDir="C:\Users\kyvan\OneDrive - dnsnetworks.ca\DMARC"

cd "$remoteDir" || exit

for reports in * ; do
    if file "$reports" | grep gzip ; then
        gunzip "$reports"
    elif file "$reports" | grep Zip ; then
        unzip "$reports"
    fi
    rm -f "$reports"
done