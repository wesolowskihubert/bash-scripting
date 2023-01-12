#!/bin/bash

# Decryption
echo "Enter the file name to decrypt (with path):"
read file
echo "Enter the password:"
read -s password

openssl enc -d -aes-256-cbc -in "$file" -out "$file.dec" -k "$password"

# Removing original file
rm "$file"

# Renaming the decrypted file
mv "$file.dec" "$file"

echo "File successfully decrypted"