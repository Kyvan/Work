#!/bin/bash -ux

# Ask how many users are being created
read -p "How many users do you need to make? " userCount

myHome=`who | awk '{print $1}'`

# For loop to make the users, add them to the proper group
# and generate RSA keys for them
for (( i = 0 ; i < $userCount ; i++ )) ; do

        # Asks for username and password
        read -p "What's the username? " userName
        read -p "What's the password? " userPass

        # Variable to hold user home directory
        userHome="/home/$userName"

        # Creates the user and sets their password
        pass=$(perl -e 'print crypt($ARGV[0], "password")' $userPass)
        useradd $userName -G sudo -md /home/$userName -p $pass -s /bin/bash

        # Makes upload and .ssh folders in user home directory
        mkdir $userHome/upload $userHome/.ssh

        # Generate RSA key and renames the public to the correct name
        ssh-keygen -t rsa -N "" -f $userHome/.ssh/"$userName"_rsa
        mv $userHome/.ssh/"$userName"_rsa.pub $userHome/.ssh/authorized_keys

        # Changes ownership user folders
        chown -R $userName:$userName $userHome/.ssh $userHome/upload

        # Change the permissions for the .ssh folder and RSA keys
        chmod 0700 $userHome/.ssh $userHome/.ssh/authorized_keys
        chmod 0600 $userHome/.ssh/"$userName"_rsa

        # Move the private key
        cp $userHome/.ssh/"$userName"_rsa /home/"$myHome"/.

        # Add permissions to allow RSA key download
        chmod o+rwx /home/"$myHome"/"$userName"_rsa
done