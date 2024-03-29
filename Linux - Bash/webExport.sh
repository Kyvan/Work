#!/bin/bash -u

while read -r line ; do

    # Database variables
    dbName=$(grep 'DB_NAME' "$line"/wp-config.php | awk '{print $3}' | awk -F \' '{print $2}')
    dbUser=$(grep 'DB_USER' "$line"/wp-config.php | awk '{print $3}' | awk -F \' '{print $2}')
    dbPass=$(grep 'DB_PASSWORD' "$line"/wp-config.php | awk '{print $3}' | awk -F \' '{print $2}')

    # SQL dump    
    mysqldump -u"$dbUser" -p"$dbPass" "$dbName" >> "$line"/"$line".sql
    
    # gzip archive of website
    tar -czf "$line"/"$line".tar.gz "$line"/* "$line"/.??*
done < mf-dev.txt


testing="stuff that matters"

ls $testing