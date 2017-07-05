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

version="$(grep -o "[[:digit:]]" /etc/centos-release | head -1)"
mac="$(ip add | grep 'link/ether' | awk '{print $2}')"
intName7="$(ip add | grep ens | awk '{print $2}' | awk -F \: '{print $1}')"
intName6="$(ip add | grep ens | awk '{print $2}' | awk -F \: '{print $1}')"

sed -i "116s/localhost/all/" /etc/postfix/main.cf
sed -i "318i relayhost = 64.26.137.70" /etc/postfix/main.cf

\cp /root/Work/snmpd /etc/snmp/snmpd.conf

read -p "What is your Community Name for this server? " comName
sed -i "s/PL#KSN!X1/$comName/" /etc/snmp/snmpd.conf

systemctl restart postfix
systemctl restart snmpd

read -p "What is the username for the new user? " user
useradd $user
read -p "What is the password for the new user? " pass
echo $user:$pass | chpasswd
sed -i "92i $user	ALL=(ALL)	ALL" /etc/sudoers

read -p "What is the hostname? " host
sed -i "s/$(cat /etc/hostname)/$host/" /etc/hostname

read -p "What is your Net Mask? " netMask
read -p "What is your IP address? " ipADD
read -p "What is your Gateway? " gtwy
read -p "What is your broadcast? " bcast
read -p "What is your first DNS IP? " dns1
read -p "What is your second DNS IP? " dns2

if (( $version == 7 )) ; then
	mv /etc/sysconfig/network-scripts/ifcfg-eno16777984 /etc/sysconfig/network-scripts/ifcfg-$intName

	sed -i "22i HARDWARE=$mac" /etc/sysconfig/network-scripts/ifcfg-$intName7
	sed -i "s/eno16777984/$intName7/g" /etc/sysconfig/network-scripts/ifcfg-$intName7
	sed -i "s/10.22.1.172/$ipADD/" /etc/sysconfig/network-scripts/ifcfg-$intName7
	sed -i "s/10.22.1.1/$gtwy/" /etc/sysconfig/network-scripts/ifcfg-$intName7
	sed -i "s/255.255.255.0/$netMask/" /etc/sysconfig/network-scripts/ifcfg-$intName7
	sed -i "s/10.22.1.255/$bcast/" /etc/sysconfig/network-scripts/ifcfg-$intName7
	sed -i "s/10.22.1.80/$dns1/" /etc/sysconfig/network-scripts/ifcfg-$intName7
	sed -i "s/10.22.1.81/$dns2/" /etc/sysconfig/network-scripts/ifcfg-$intName7

	systemctl restart NetworkManager
	
elif (( $version == 6 )) ; then
	mv /etc/sysconfig/network-scripts/ifcfg-eth0 /etc/sysconfig/network-scripts/ifcfg-$intName

	sed -i '/HWADDR/d' /etc/sysconfig/network-scripts/ifcfg-$intName6
	sed -i "6i HWADDR=$mac" /etc/sysconfig/network-scripts/ifcfg-$intName6
	sed -i "s/eth0/$intName6/g" /etc/sysconfig/network-scripts/ifcfg-$intName6
	sed -i "s/10.22.1.171/$ipADD/" /etc/sysconfig/network-scripts/ifcfg-$intName6
	sed -i "s/10.22.1.1/$gtwy/" /etc/sysconfig/network-scripts/ifcfg-$intName6
	sed -i "s/255.255.255.0/$netMask/" /etc/sysconfig/network-scripts/ifcfg-$intName6
	sed -i "s/10.22.1.255/$bcast/" /etc/sysconfig/network-scripts/ifcfg-$intName6
	sed -i "s/10.22.1.80/$dns1/" /etc/sysconfig/network-scripts/ifcfg-$intName6
	sed -i "s/10.22.1.81/$dns2/" /etc/sysconfig/network-scripts/ifcfg-$intName6
	sed -i '10s/yes/no/' /etc/sysconfig/network-scripts/ifcfg-$intName6
	
	service NetworkManager stop
	chkconfig NetworkManager off
	service network restart
fi

read -p "Are you installing PLESK or phpMyAdmin? (Plesk/PHP) " choice

if [ ${choice,,} == "plesk" ] ; then
	wget http://autoinstall.plesk.com/plesk-installer
	chmod +x plesk-installer
	./plesk-installer
	
	sed -i "10i -A INPUT -p tcp -m tcp --dport 8447 -j ACCEPT" /etc/sysconfig/iptables
	sed -i "11i -A INPUT -p tcp -m tcp --dport 8443 -j ACCEPT" /etc/sysconfig/iptables
	sed -i "12i -A INPUT -p tcp -m tcp --dport 8880 -j ACCEPT" /etc/sysconfig/iptables
	sed -i "13i -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT" /etc/sysconfig/iptables
	sed -i "14i -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT" /etc/sysconfig/iptables

elif [ ${choice,,} == "php" ] ; then
	if (( $version == 7 )) ; then 
		wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
		wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm
		wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
		
		rpm -Uvh remi-release-7.rpm epel-release-latest-7.noarch.rpm
		rpm -ivh mysql-community-release-el7-5.noarch.rpm
		
		sed -i "10i -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT" /etc/sysconfig/iptables
		sed -i "11i -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT" /etc/sysconfig/iptables
		
		echo -e "Which version of PHP do you want to install?\nPlease put the first to digist without any dots or dashes.\nExample: for version 5.6.XX enter 56"
		read phpv

		yum-config-manager --enable remi-php$phpv
		
		yum clean all
		yum update -y
		yum install -y httpd epel-release mysql mysql-server php phpmyadmin php-mysql
		
		systemctl start mysqld
		systemctl start httpd
		systemctl enable mysqld
		systemctl enable httpd
		
	elif (( $version == 6 )) ; then
		wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
		wget http://rpms.remirepo.net/enterprise/remi-release-6.rpm
		wget http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm
		
		rpm -Uvh remi-release-7.rpm epel-release-latest-6.noarch.rpm
		rpm -ivh mysql-community-release-el6-5.noarch.rpm
		
		sed -i "10i -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT" /etc/sysconfig/iptables
		sed -i "11i -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT" /etc/sysconfig/iptables
		
		echo -e "Which version of PHP do you want to install?\nPlease put the first to digist without any dots or dashes.\nExample: for version 5.6.XX enter 56"
		read phpv

		yum-config-manager --enable remi-php$phpv
		
		yum clean all
		yum update -y
		yum install -y httpd epel-release mysql mysql-server php phpmyadmin php-mysql
		
		service mysqld start
		service httpd start
		chkconfig mysqld on
		chkconfig httpd on
		
	fi

	

else
	echo -e "Your answer doesn't match any of the options.\nSo I guess we are done here."
fi
