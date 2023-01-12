#!/bin/bash

# Retrieve public IP address
public_ip=$(curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//')

# Print public IP address
echo "Public IP: $public_ip"