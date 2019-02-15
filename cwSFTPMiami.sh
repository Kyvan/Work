#!/bin/bash -ux

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
	userID=`grep $userName /etc/passwd | awk -F \: '{ print $3 }'`

	# Adds users
	adduser $userName -md /app/$userName -G sftpUsers

	# Change the user home directory owner
	chown root:root $userHome

	# Sets the password for the newly created user
	echo $userPass | passwd $userName --stdin

	# Makes upload and .ssh folders in user home directory
	mkdir $userHome/upload $userHome/.ssh

	# Asks for the IP of the server hosting the shared drive
	read -p "What's the IP for the server? " serverIP

	# Adds the line to /etc/fstab to automount the shared drive on startup
	echo -e "//$serverIP/DataDump $userHome/upload cifs user,rw,uid=$userID,username=$userName,password=userPass 0 0" >> /etc/fstab

	# Generates the RSA key for the user
	ssh-keygen -t rsa -N "" -f $userHome/.ssh/$userName_rsa
	mv $userHome/.ssh/$userName_rsa.pub $userHome/.ssh/authorized_keys

	# Changes ownership user folders
	chown -R $userName:$userName .ssh upload

	# Change the permissions for the .ssh folder and RSA keys
	chmod 0700 $userHome/.ssh $userName/.ssh/authorized_keys
	chmod 0600 $userHome/.ssh/$userName_rsa

done

mount -a
