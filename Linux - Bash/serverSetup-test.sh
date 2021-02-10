#!/bin/bash -u

#########################################################################################
#				   Made by Kyvan Emami	   			  	#
#				  DATE:	   May 12th, 2017  			  	#
#				Script to setup Linux Boxes				#
#				    Services include:	   			  	#
#					  HTTPD		   			  	#
#					   PHP		   			  	#
#					  MySQL		   			  	#
#					  Plesk		   			  	#
#					phpMyAdmin	   			  	#
#########################################################################################

# Variables for Version of CentOS, MAC address of the interface, name of the interface
# There are 2 variables for the interface name (1 for CentOS 6.x and 1 for CentOS 7.x)
version="$(grep -o "[[:digit:]]" /etc/centos-release | head -1)"
mac="$(ip add | grep 'link/ether' | awk '{print $2}')"
intName7="$(ip add | grep ens | awk '{print $2}' | awk -F : '{print $1}')"
intName6="$(ip add | grep eth | awk '{print $2}' | awk -F : '{print $1}')"

# Function to make users
function userCreation {
	# A for loop that makes the number of users specified based on the previous question
	for (( i = 0 ; i < "$userNum" ; i++ )) ; do
		# Asks for the username and then adds the user
		read -rp "What is the username for the new user? " user
		useradd "$user"

		# Asks for the password and then adds the password for the user
		read -rp "What is the password for the new user? " pass
		echo "$user":"$pass" | chpasswd

		# Adds the new user to the SUDOERS file so it has SUDO access
		sed -i "92i $user	ALL=(ALL)	ALL" /etc/sudoers
	done
}

# Using sed to replace and add lines in POSTFIX to relay to IronPort
sed -i "116s/localhost/all/" /etc/postfix/main.cf
sed -i "318i relayhost = 64.26.137.70" /etc/postfix/main.cf

# Copies and overwrites the SNMP.conf
#\cp /root/Work/snmpd /etc/snmp/snmpd.conf

# Asks for the community name to be used for SNMP
read -rp "What is your Community Name for this server? " comName
sed -i "s/PL#KSN!X1/$comName/" /etc/snmp/snmpd.conf

# Restarts POSTFIX and SNMPD for the changes to take effect
systemctl restart postfix
systemctl restart snmpd

# Ask how many users needs to be made
read -rp "How many users do you need to make (enter in number format)? " userNum

# Calls the functiontion to make users
userCreation userNum

# Asks for the hostname and changes the hostname for the box
read -rp "What is the hostname? " host
sed -i "s/$(cat /etc/hostname)/$host/" /etc/hostname

# Asks for the Networkign information (net mask, IP address, gateway, broadcast, DNS1, and DNS2)
read -rp "What is your Net Mask? " netMask
read -rp "What is your IP address? " ipADD
read -rp "What is your Gateway? " gtwy
read -rp "What is your broadcast? " bcast
read -rp "What is your first DNS IP? " dns1
read -rp "What is your second DNS IP? " dns2

# Function to fix the networking issue caused by cloning the box (centOS 7.x)
function networkFixer7 {
	# Renames the interface config file name to the new one (needed because of clonign issues)
	mv /etc/sysconfig/network-scripts/ifcfg-eno16777984 /etc/sysconfig/network-scripts/ifcfg-"$intName7"

	# Replaces the old information with the new ones optained from the question asked earlier
	sed -i "22i HARDWARE=$mac" /etc/sysconfig/network-scripts/ifcfg-"$intName7"
	sed -i "s/eno16777984/$intName7/g" /etc/sysconfig/network-scripts/ifcfg-"$intName7"
	sed -i "s/10.22.1.172/$ipADD/" /etc/sysconfig/network-scripts/ifcfg-"$intName7"
	sed -i "s/10.22.1.1/$gtwy/" /etc/sysconfig/network-scripts/ifcfg-"$intName7"
	sed -i "s/255.255.255.0/$netMask/" /etc/sysconfig/network-scripts/ifcfg-"$intName7"
	sed -i "s/10.22.1.255/$bcast/" /etc/sysconfig/network-scripts/ifcfg-"$intName7"
	sed -i "s/10.22.1.80/$dns1/" /etc/sysconfig/network-scripts/ifcfg-"$intName7"
	sed -i "s/10.22.1.81/$dns2/" /etc/sysconfig/network-scripts/ifcfg-"$intName7"

	# Restart NetworkManager for the changes to take effect
	systemctl restart NetworkManager
}

# Function to fix the networking issue caused by cloning the box (centOS 6.x)
function networkFixer6 {
	# Renames the interface config file name to the new one (needed because of clonign issues)
	mv /etc/sysconfig/network-scripts/ifcfg-eth0 /etc/sysconfig/network-scripts/ifcfg-"$intName6"

	# Replaces the old information with the new ones optained from the question asked earlier
	sed -i '/HWADDR/d' /etc/sysconfig/network-scripts/ifcfg-"$intName6"
	sed -i "6i HWADDR=$mac" /etc/sysconfig/network-scripts/ifcfg-"$intName6"
	sed -i "s/eth0/$intName6/g" /etc/sysconfig/network-scripts/ifcfg-"$intName6"
	sed -i "s/10.22.1.171/$ipADD/" /etc/sysconfig/network-scripts/ifcfg-"$intName6"
	sed -i "s/10.22.1.1/$gtwy/" /etc/sysconfig/network-scripts/ifcfg-"$intName6"
	sed -i "s/255.255.255.0/$netMask/" /etc/sysconfig/network-scripts/ifcfg-"$intName6"
	sed -i "s/10.22.1.255/$bcast/" /etc/sysconfig/network-scripts/ifcfg-"$intName6"
	sed -i "s/10.22.1.80/$dns1/" /etc/sysconfig/network-scripts/ifcfg-"$intName6"
	sed -i "s/10.22.1.81/$dns2/" /etc/sysconfig/network-scripts/ifcfg-"$intName6"
	sed -i '10s/yes/no/' /etc/sysconfig/network-scripts/ifcfg-"$intName6"

	# Stop and Disable NetworkManager and restart network for the changes to tale effect
	service NetworkManager stop
	chkconfig NetworkManager off
	service network restart
}

# If statement to check the version of CentOS box and call the correct function to fix netwroking issues
if (( "$version" == 6 )) ; then
	networkFixer6 version intName6 mac ipADD bcast gtwy netMask dns1 dns2
elif (( "$version" == 7 )) ; then
	networkFixer7 version intName7 mac ipADD bcast gtwy netMask dns1 dns2
fi

# Function to install plesk
function pleskInstall {
	# Gets the PLESK installer from the PLESK website using wget
	wget http://autoinstall.plesk.com/plesk-installer
	# Adds execute permission to the installer so it can be executed
	chmod +x plesk-installer
	# Runs the installer
	./plesk-installer

	# Inserts the rules needed for PLESK to communicate to the outside world to IPTABLES
	sed -i "10i -A INPUT -p tcp -m tcp --dport 8447 -j ACCEPT" /etc/sysconfig/iptables
	sed -i "11i -A INPUT -p tcp -m tcp --dport 8443 -j ACCEPT" /etc/sysconfig/iptables
	sed -i "12i -A INPUT -p tcp -m tcp --dport 8880 -j ACCEPT" /etc/sysconfig/iptables
	sed -i "13i -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT" /etc/sysconfig/iptables
	sed -i "14i -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT" /etc/sysconfig/iptables

	# Restarts IPTABLES service for the changes to take effect
	systemctl restart iptables
}

# Function to install phpMyAdmin (CentOS 6.x)
function phpInstall6 {
	# Gets the repositories for EPEL, PHP, and MySQL from their websites
	wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
	wget http://rpms.remirepo.net/enterprise/remi-release-6.rpm
	wget http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm

	# Installs the repositories
	rpm -Uvh remi-release-7.rpm epel-release-latest-6.noarch.rpm
	rpm -ivh mysql-community-release-el6-5.noarch.rpm

	# Inserts the rules needed for phpMyAdmin to communicate with the outside world to IPTABLES
	sed -i "10i -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT" /etc/sysconfig/iptables
	sed -i "11i -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT" /etc/sysconfig/iptables

	# Restarts IPTABLES service for the above changes to take effect
	service iptables restart

	# Ask the user for the version of PHP they need to isntall
	echo -e "Which version of PHP do you want to install?\nPlease put the first to digits without any dots or dashes.\nExample: for version 5.6.XX enter 56"
	read -r phpv

	# Enables the repository needed for the version of PHP that needs to be installed
	yum-config-manager --enable remi-php"$phpv"
	# Cleans the repositories to get rid of the unused ones, updates the box, and then installs the needed packages

	yum clean all
	yum update -y
	yum install -y httpd epel-release mysql mysql-server php phpmyadmin php-mysql php-mbstring

	# Restart and Enable MySQL and HTTP services
	service mysqld start
	service httpd start
	chkconfig mysqld on
	chkconfig httpd on
}

# Function to install phpMyAdmin (CentOS 7.x)
function phpInstall7 {
	# Gets the repositories for EPEL, PHP, and MySQL from their websites
	wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
	wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm
	wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm

	# Installs the repositories
	rpm -Uvh remi-release-7.rpm epel-release-latest-7.noarch.rpm
	rpm -ivh mysql-community-release-el7-5.noarch.rpm

	# Inserts the rules needed for phpMyAdmin to communicate with the outside world to IPTABLES
	sed -i "10i -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT" /etc/sysconfig/iptables
	sed -i "11i -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT" /etc/sysconfig/iptables

	# Restarts IPTABLES service for the above changes to take effect 
	systemctl restart iptables

	# Ask the user for the version of PHP they need to isntall
	echo -e "Which version of PHP do you want to install?\nPlease put the first to digist without any dots or dashes.\nExample: for version 5.6.xx enter 56"
	read -r phpv

	# Enables the repository needed for the version of PHP that needs to be installed
	yum-config-manager --enable remi-php"$phpv"

	# Cleans the repositories to get rid of the unused ones, updates the box, and then installs the needed packages
	yum clean all
	yum update -y
	yum install -y httpd epel-release mysql mysql-server php phpmyadmin php-mysql php-mbstring

	# Restart and Enable MySQL and HTTP services
	systemctl start mysqld
	systemctl start httpd
	systemctl enable mysqld
	systemctl enable httpd
}

# Asks user if they need to install PLESK or phpMyAdmin
read -rp "Are you installing PLESK or phpMyAdmin? (Plesk/PHP) " choice

# An IF statement to check the user's answer to install the appropriate packages
if [ "${choice,,}" == "plesk" ] ; then
	pleskInstall
elif [ "${choice,,}" == "php" ] ; then
	# A nested IF statement to check the version of CentOS installed and install the appropriate packages based on the version of CentOS
	if (( "$version" == 7 )) ; then 
		phpInstall7
	elif (( "$version" == 6 )) ; then
		phpInstall6
	fi
else
	# An echo statement telling you the the choice you made was not one of the options provided and then stops the script
	echo -e "Your answer doesn't match any of the options.\nSo I guess we are done here."
fi
