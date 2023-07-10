#!/bin/bash

#file name and password fror encryption
echo "Enter the file name (with path):"
read file
echo "Enter the password:"
read -s password

#openssl encruption
openssl enc -aes-256-cbc -salt -in "$file" -out "$file.enc" -k "$password"

#removing the original file (not necessary)
rm "$file"

#renaming encrypted file to the original file name
mv "$file.enc" "$file"

echo "File successfully encrypted"