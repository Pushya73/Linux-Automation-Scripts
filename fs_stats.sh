#!/bin/bash

FU=$( df -H | grep -Ev "Filesystem|tmpfs" | grep "sda2" | awk '{print $5}' | tr -d % 
)
TO="bigport.io@gmail.com"

if [[ $FU -ge 80 ]]
then 
	echo "WARNING!! DISK space is low -$FU %" | mail -s "DISK SPACE ALERT!!!" $TO
else
	echo "There is sufficient DISK space"
fi
