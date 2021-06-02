#!/bin/bash -u

while read -r line ; do
    echo New-MailboxExportRequest -Mailbox "$line" -FilePath \\\\mbx1\\PSTs\\"$line".pst -BadItemLimit 45
    #echo $line 
done < ./audiOttawa1.txt