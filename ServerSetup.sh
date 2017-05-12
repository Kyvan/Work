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

yum install -y wget yum-utils git

read -p "Are you installing PLESK or phpMyAdmin? (Plesk/PHP)" choice

if [ ${$choice,,} == "plesk" ] ; then
	wget http://autoinstall.plesk.com/plesk-installer
	chmod +x plesk-installer
	./plesk-installer

elif [ ${$choice,,} == "php" ] ; then
	wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
	wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm
	wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
	
	rpm -Uvh remi-release-7.rpm epel-release-latest-7.noarch.rpm
	rpm -ivh mysql-community-release-el7-5.noarch.rpm
	
	echo -e "Which version of PHP do you want to install?\nPlease put the first to digist without any dots or dashes.\nExample for version 5.6.XX: 56"
	read phpv
	
	yum-config-manager --enable remi-php$phpv
	
	yum clean all
	yum update -y
	yum install -y httpd epel-release mysql-server

	
	yum install -y php phpmyadmin
else
	echo -e "Your answer doesn't match any of the options.\nSo I guess we are done here."
fi
