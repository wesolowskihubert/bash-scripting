#!/bin/bash

#check public IP address and print it
public_ip=$(curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//')
echo "Public IP: $public_ip"