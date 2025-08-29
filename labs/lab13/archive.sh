#!/bin/bash

TARGET_DIR=$1
ARCHIVE_NAME="archive_$(date +%y-%m-%d).tar.gz"

if [ -z "$TARGET_DIR" ]; then 
	echo "usage : $0 <directory_to_archive>"
	exit 1
fi

if [ ! -d "$TARGET_DIR" ]; then 
	echo "Error: '$TARGET_DIR' not found"
	exit 1
fi

echo "Archiving files in '$TARGET_DIR' for 7 days"

find "$TARGET_DIR" -type f -mtime -7 | tar -czvf "$ARCHIVE_NAME" -T -

echo "acrchive '$ARCHIVE_NAME' created "

