#!/bin/bash

NID=$(id -u)

if [[ ${NID} -ne 0 ]]
then 
	echo "Have the SUDO permission or be the ROOT user"
	exit 1
fi

if [[ $# -lt 2 ]]
then 
	echo "Please enter an username along with the description"
	exit 1
fi

USERNAME="${1}"

shift
COMNT="${@}"

#for password

if ! command -v openssl &> /dev/null 
then 
	echo "Install the OPENSSL via sudo pacman -S openssl"
	exit 1
fi

if id "$USERNAME" &> /dev/null
then  
	echo "The username '$USERNAME' already exists"
	exit 1
fi

PASSWORD=$(openssl rand -hex 16 | cut -c 1-5) || exit 1

#create the user
useradd -m -c "$COMNT" "$USERNAME"

#check the status
if [[ $? -ne 0 ]]
then 
	echo "The user hasn't been created"
 	exit 1
fi

# create the passwd
if ! chpasswd <<< "${USERNAME}:${PASSWORD}"
then
	echo "The password has been failed to create"
	userdel -r "$USERNAME"
	exit 1
fi

#edit the password in first login by user
passwd -e "$USERNAME"

#DISPLAY the stuffs

echo "USERNAME: $USERNAME"
echo "PASSWORD: $PASSWORD"
echo "HOSTNAME: $(hostname)"

echo "The process has been completed"
echo "====================================================="
