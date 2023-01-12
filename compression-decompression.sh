#!/bin/bash

# File compression/decompression script

# Check if the number of arguments is correct
if [ $# -ne 2 ]; then
  echo "Usage: $0 [compress/decompress] [file/directory]"
  exit 1
fi

# Set the action (compress or decompress) and target (file or directory)
action=$1
target=$2

# Check if the action is "compress" or "decompress"
if [ "$action" != "compress" ] && [ "$action" != "decompress" ]; then
  echo "Error: Invalid action. Use 'compress' or 'decompress'."
  exit 1
fi

# Check if the target is a file or directory
if [ ! -f "$target" ] && [ ! -d "$target" ]; then
  echo "Error: Invalid target. Use a file or directory."
  exit 1
fi

# Compress or decompress the target
if [ "$action" == "compress" ]; then
  # Compress the target using tar
  tar -czvf "$target.tar.gz" "$target"
  echo "Successfully compressed $target to $target.tar.gz"
else
  # Decompress the target using tar
  tar -xzvf "$target"
  echo "Successfully decompressed $target"
fi