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
	userHome="/sftp/test/$userName"
	userID=`grep $userName /etc/passwd | awk -F \: '{ print $3 }'`
	 
	# Adds users
	adduser $userName -md /sftp/test/$userName -G SFTPUsers

	# Sets the password for the newly created user
	echo $userPass | passwd $userName --stdin

	# Makes upload and .ssh folders in user home directory
	mkdir $userHome/upload $userHome/.ssh

	# Asks for the IP of the server hosting the shared drive
	read -p "What's the IP for the server? " serverIP

	echo -e "//$serverIP/DataDump $userHome/upload cifs user,rw,uid=$userID,username=$userName,password=userPass 0 0" >> /etc/fstab
done

mount -a