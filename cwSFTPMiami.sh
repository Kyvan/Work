#!/bin/bash -u

# Asks how many users are being created
read -p "How many users are you making? " numUser

# Loop to make the user(s)
for (( i = 0 ; i < $numUser ; i++ )) ; do

        # Asks for the username
        read -p "What's the username? " userName

        # Asks for user password
        read -p "What's the password? " userPass

        # Makes variables for user home directory and UID
        userHome="/app/$userName"

        # Adds users
        adduser $userName -md /app/$userName -G sftpUsers

        # Change the user home directory owner
        chown root:root $userHome

        # Change the user home directory permissions
        chmod 0755 $userHome

        # Sets the password for the newly created user
        echo $userPass | passwd $userName --stdin

        # Makes upload and .ssh folders in user home directory
        mkdir $userHome/upload $userHome/.ssh

        # Asks for the IP of the server hosting the shared drive
        read -p "What's the IP for the server? " serverIP

        # Adds the line to /etc/fstab to automount the shared drive on startup
        echo //$serverIP/DataDump $userHome/upload cifs user,rw,uid=`grep $userName /etc/passwd | awk -F \: '{ print $3 }'`,username=$userName,password=$userPass 0 0 >> /etc/fstab

        # Generates the RSA key for the user
        ssh-keygen -t rsa -N "" -f $userHome/.ssh/"$userName"_rsa
        mv $userHome/.ssh/"$userName"_rsa.pub $userHome/.ssh/authorized_keys

        # Changes ownership user folders
        chown -R $userName:$userName $userHome/.ssh $userHome/upload

        # Change the permissions for the .ssh folder and RSA keys
        chmod 0700 $userHome/.ssh $userHome/.ssh/authorized_keys
        chmod 0600 $userHome/.ssh/"$userName"_rsa

        # Move the private key
        cp $userHome/.ssh/"$userName"_rsa /home/almond/.

        # Add permissions to allow RSA key download
        chmod o+rwx /home/almond/"$userName"_rsa
done

mount -a
