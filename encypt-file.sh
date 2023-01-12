#!/bin/bash

# Get the file name and password from the user
echo "Enter the file name (with path):"
read file
echo "Enter the password:"
read -s password

# Encrypt the file using openssl
openssl enc -aes-256-cbc -salt -in "$file" -out "$file.enc" -k "$password"

# Remove the original file (optional)
rm "$file"

# Rename the encrypted file to the original file name
mv "$file.enc" "$file"

echo "File successfully encrypted"