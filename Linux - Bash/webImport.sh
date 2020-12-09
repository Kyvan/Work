#!/bin/bash -u

# Subscription creation
plesk bin subscription --create mf-dev.ca -owner Mediaforce -service-plan\
"Default Domain" -ip 148.59.149.x -login mediaforce -passwd "AwfulComprise03"


while read line ; do

    # Site creation
    plesk bin site --create $line -webspace-name mf-dev.ca -www-root /$line

    # Database variables
    dbName=$(grep 'DB_NAME' $line/wp-config.php | awk '{print $3}' | awk -F \' '{print $2}')
    dbUser=$(grep 'DB_USER' $line/wp-config.php | awk '{print $3}' | awk -F \' '{print $2}')
    dbPass=$(grep 'DB_PASSWORD' $line/wp-config.php | awk '{print $3}' | awk -F \' '{print $2}')

    # Database creation
    plesk bin database --create $dbName -domain $line -type mysql

    # SQL dump    
    mysqldump -u$dbUser -p\'$dbPass\' $dbName >> $line/$line.sql
    
    # gzip archive of website
    tar -czf $line/$line.tar.gz $line/* $line/.??*
done < mf-dev.txt