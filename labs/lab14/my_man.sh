#!/bin/bash

if [ $# -eq 0 ]; then 
	echo "Used : $0 <command>"
	exit 1
fi

cmd="$1"
man_page="/usr/share/man/man1/${cmd}.1.gz"

if [ -f "$man_page" ]; then
	zcat "$man_page" | less
else 
	echo "Command isnt found '$cmd' "

fi


