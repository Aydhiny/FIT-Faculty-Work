#!/bin/bash

adresa="192.168.1"

for ip in {1..254};
do
	ip="$adresa.$ip"

	ping -c 1 "$ip"

	if [ $? -eq 0 ]; then
	echo "Aktivna IP adresa: $ip"
	fi

done
