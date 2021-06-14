# Installing iptables
yum install -y iptables

# Disable firewalld
systemctl stop firewalld
systemctl disable firewalld
systemctl start iptables
systemctl enable iptables

# Setting up the rules
iptables -A INPUT -p tcp --dport 5999 -s 172.16.31.167 -j REJECT
iptables -A INPUT -p tcp --dport 5999 -s 172.16.31."$MN" -j REJECT
iptables -A INPUT -p tcp --dport 5999 -j ACCEPT