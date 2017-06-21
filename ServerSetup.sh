#!/bin/bash -u

###########################################
#	   Made by Kyvan Emami		  #
#	 DATE:	  May 12th, 2017	  #
#	Script to setup Linux Boxes	  #
#	    Services include:		  #
#		  HTTPD			  #
#		   PHP			  #
#		  MySQL			  #
#		  Plesk			  #
#		phpMyAdmin		  #
###########################################

version="$(cat /etc/centos-release | awk '{print $4}' | awk -F \. '{print $1}')"

yum install -y wget yum-utils git iptables-services bash-completion

systemctl stop firewalld
systemctl disable firewalld

sed -i 's/#//' /etc/ssh/sshd_config
sed -i 's/22/10022/' /etc/ssh/sshd_config
sed -i 's/22/10022/' /etc/sysconfig/iptables

systemctl restart sshd
systemctl start itpables
systemctl enable iptables

read -p "Are you installing PLESK or phpMyAdmin? (Plesk/PHP) " choice

if [ ${choice,,} == "plesk" ] ; then
	wget http://autoinstall.plesk.com/plesk-installer
	chmod +x plesk-installer
	./plesk-installer

elif [ ${choice,,} == "php" ] ; then
	if (( $version == 7 )) ; then 
		wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
		wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm
		wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
		
		rpm -Uvh remi-release-7.rpm epel-release-latest-7.noarch.rpm
		rpm -ivh mysql-community-release-el7-5.noarch.rpm
		
	elif (( $version == 6 )) ; then
		wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
		wget http://rpms.remirepo.net/enterprise/remi-release-6.rpm
		wget http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm
		
		rpm -Uvh remi-release-7.rpm epel-release-latest-6.noarch.rpm
		rpm -ivh mysql-community-release-el6-5.noarch.rpm
	fi
	
	echo -e "Which version of PHP do you want to install?\nPlease put the first to digist without any dots or dashes.\nExample: for version 5.6.XX enter 56"
	read phpv

	yum-config-manager --enable remi-php$phpv
	
	yum clean all
	yum update -y
	yum install -y httpd epel-release mysql mysql-server php phpmyadmin 
	
	systemctl start mysqld
	systemctl start httpd
	systemctl enable mysqld
	systemctl enable httpd

else
	echo -e "Your answer doesn't match any of the options.\nSo I guess we are done here."
fi
