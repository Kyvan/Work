read -p "What's the username?" userName
read -p "What's the password?" userPass

useradd $userName
echo $userPass | passwd $userName --stdin
sed -i "100i $userName\	ALL=(ALL)\	ALL" /etc/sudoers
