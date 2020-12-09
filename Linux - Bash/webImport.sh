#!/bin/bash -u

read -p "What is the parent domain? " pDomain

if [ $pDomain == mf-tested.com ] ; then
    # Subscription creation
    plesk bin subscription --create $pDomain -owner Mediaforce -service-plan\
    "Default Domain" -ip 148.59.149.43 -login mediaforce-tested -passwd "AwfulComprise03#"
elif [ $pDomain == mf-dev.ca ] ; then
    # Subscription creation
    plesk bin subscription --create $pDomain -owner Mediaforce -service-plan\
    "Default Domain" -ip 148.59.149.43 -login mediaforce-dev -passwd "ShoutOrganism03#"
fi

while read line ; do

    # Site creation
    plesk bin site --create $line -webspace-name $pDomain -www-root /$line

    # Database variables
    dbName=$(grep 'DB_NAME' $line/wp-config.php | awk '{print $3}' | awk -F \' '{print $2}')
    dbUser=$(grep 'DB_USER' $line/wp-config.php | awk '{print $3}' | awk -F \' '{print $2}')
    dbPass=$(grep 'DB_PASSWORD' $line/wp-config.php | awk '{print $3}' | awk -F \' '{print $2}')

    # Database creation
    plesk bin database --create $dbName -domain $line -type mysql

    # SQL dump    
    mysqldump -u$dbUser -p$dbPass $dbName >> $line/$line.sql
    
    # gzip archive of website
    tar -xzf /app/$line.tar.gz -C /var/www/vhosts/$line/* $line/.??*
done < mf-dev.txt