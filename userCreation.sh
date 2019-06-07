#!/bin/bash -u

# Ask how many users are being created
read -p "How many users do you need to make?" userCount

# For loop to make the users, add them to the proper group
# and generate RSA keys for them
for (( i = 0 ; i < $userCount ; i++ )) ; do
	
	# Asks for username and password
	read -p "What's the username?" userName
	read -p "What's the password?" userPass
	
	# Creates the user and sets their password
	useradd $userName -G sudo -s /bin/bash
	echo $userPass | passwd $userName --stdin
	
	# Generate RSA key and renames the public to the correct name
	ssh-keygen -t rsa -N "" -f $userHome/.ssh/"$userName"_rsa
    mv $userHome/.ssh/"$userName"_rsa.pub $userHome/.ssh/authorized_keys

    # Changes ownership user folders
	chown -R $userName:$userName $userHome/.ssh $userHome/upload

    # Change the permissions for the .ssh folder and RSA keys
    chmod 0700 $userHome/.ssh $userHome/.ssh/authorized_keys
    chmod 0600 $userHome/.ssh/"$userName"_rsa

	# Move the private key
    cp $userHome/.ssh/"$userName"_rsa /home/`who | awk '{print $1}'`/.

    # Add permissions to allow RSA key download
    chmod o+rwx /home/`who | awk '{print $1}'`/"$userName"_rsa
done