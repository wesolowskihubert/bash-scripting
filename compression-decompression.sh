#!/bin/bash

#file compression/decompression script

#checking if the number of arguments is correct
if [ $# -ne 2 ]; then
  echo "Usage: $0 [compress/decompress] [file/directory]"
  exit 1
fi

#select action compress/decompress and target
action=$1
target=$2

#checking action
if [ "$action" != "compress" ] && [ "$action" != "decompress" ]; then
  echo "Error: Invalid action. Use 'compress' or 'decompress'."
  exit 1
fi

#checking if traget is file or dir
if [ ! -f "$target" ] && [ ! -d "$target" ]; then
  echo "Error: Invalid target. Use a file or directory."
  exit 1
fi

#perform action
if [ "$action" == "compress" ]; then
  # tar compress
  tar -czvf "$target.tar.gz" "$target"
  echo "Successfully compressed $target to $target.tar.gz"
else
  # tar decompress
  tar -xzvf "$target"
  echo "Successfully decompressed $target"
fi