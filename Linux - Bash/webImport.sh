#!/bin/bash -u

# Grab domain and IP address information
read -rp "What is the parent domain? " pDomain
#read -rp "What is the IP address of the server? " ipAdd
#read -rp "Who is the owner of the website? " ownerName
#read -rp "What is the username of the website? " webUser

# Creates password
#pass="$(perl -e 'print crypt($ARGV[0], "password")' $webPass)"

# Subscription creation
#plesk bin subscription --create "$pDomain" -owner "$ownerName" -service-plan "Default Domain" -ip "$ipAdd" -login "$webUser" -passwd "$webPass"

while read -r line ; do

    # Site creation
    plesk bin site --create "$line" -webspace-name "$pDomain" -www-root /"$line"
    
    # gzip archive of website
    tar -xzf /app/"$line".tar.gz -C /var/www/vhosts/"$line"
    
    # Database variables
    dbName=$(grep 'DB_NAME' /var/www/vhosts/"$line"/wp-config.php | awk '{print $3}' | awk -F \' '{print $2}')
    dbUser=$(grep 'DB_USER' /var/www/vhosts/"$line"/wp-config.php | awk '{print $3}' | awk -F \' '{print $2}')
    dbPass=$(grep 'DB_PASSWORD' /var/www/vhosts/"$line"/wp-config.php | awk '{print $3}' | awk -F \' '{print $2}')

    # Database creation
    plesk bin database --create-dbuser "$dbUser" -passwd "$dbPass" -domain "$line" -server localhost:3306 -database "$dbName" 

    # SQL dump    
    mysql -u"$dbUser" -p"$dbPass" "$dbName" < /var/www/vhosts/"$line"/"$line".sql
    
    
done < mf-dev.txt