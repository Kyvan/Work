read -p "How many users do you need to make?" userCount

for (( i = 0 ; i < $userCount ; i++ )) ; do
	read -p "What's the username?" userName
	read -p "What's the password?" userPass
	useradd $userName
	echo $userPass | passwd $userName --stdin
	sed -i "100i $userName ALL=(ALL) ALL" /etc/sudoers
done