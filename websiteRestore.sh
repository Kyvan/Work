#!/bin/bash -u

# Variables
rootDir="/var/www/vhosts/eastrock.com/httpdocs"
tarName="eastrockClean.tar.gz"

# Goes to website root directory
cd $rootDir

# Loop to remove all files except the tar file
for fileName in * ; do
    if [[ $fileName != $tarName ]] ; then
        \rm -rf $fileName
    fi
done

# Untaring the website
tar xzf $tarName

# Changing the permissions/ownership
chown -R webmaster:psacln ./* ./.??*
find ./ -type d -exec chmod 0755 {} \;
find ./ -type f -exec chmod 0644 {} \;
chmod 0400 wp-config.php