#!/bin/bash -u 

dir=$( date +%F )
mkdir -p /app/mysql.backup/"$dir"

for db in $(mysql -uadmin -p"$(cat /etc/psa/.psa.shadow)" -e 'show databases' -s --skip-column-names); do
    if [[ "$db" != *schema* && "$db" != *phpmyadmin* && "$db" != "event" && "$db" != "psa" && "$db" != "mysql" ]] ; then
        mysqldump -uadmin -p"$(cat /etc/psa/.psa.shadow)" --skip-lock-tables "$db" > /app/mysql.backup/"$dir"/"$db".sql
    fi
done

find /app/mysql.backup/ -ctime +3 -type d -exec rm -rf {} \;