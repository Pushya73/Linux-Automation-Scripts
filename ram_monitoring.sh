#!/bin/bash

FREE=$( free -mt | tail -1 | awk '{print $4}' )
TH=500

if [[ $FREE -lt $TH ]]
then
	echo "WARNING!! The RAM is minimal"
else
	echo "SUFFICIENT RAM"
fi

