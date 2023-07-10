#!/bin/bash

#decryption
echo "Enter the file name to decrypt (with path):"
read file
echo "Enter the password:"
read -s password

openssl enc -d -aes-256-cbc -in "$file" -out "$file.dec" -k "$password"

#removing original file
rm "$file"

#renaming the decrypted file
mv "$file.dec" "$file"

echo "File successfully decrypted"