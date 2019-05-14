# Work

SNMPD
	
	Configs needed for the SNMPD to work properly.
	Just copy the file to /etc/snmp/snmpd.conf, overwritting the original file, change the community name if needed, and then restart snmpd for the changes to take effect.

rsyslog.sh

	Rsyslog Script probably doesn't work correctly depending on what and how you wanna use it.
	I used it for Linux to Linux (one rsyslog server and client) and it worked fine. But I had to change the whole thing when used to get logs from CISCO switches and Windows Server machines (Had to use legacy configs to make it work eventhough the new configs worked fine for Linux to Linux).

rsyslog-mail.sh

	Like rsyslog.sh, it worked fine for Linux to Linux, did not try it for CISCO and Windows Server machines.
	Might need to change the configs to legacy for the mail to work for CISCO and Windows Servers as well.

ServerSetup.sh
	
	It worked fine on CentOS 7.x when installing PLESK, don't remember if I used it for testing phpMyAdmin installation or not. :D
	Not gonna be tested on CentOS 6.x since it's too old now
  
Running the Script:

	Just add the execute permission to the script you want to run, and then run it.
	All the information needed for the script to fully run will be asked for in the script.
