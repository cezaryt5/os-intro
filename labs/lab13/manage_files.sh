#!/bin/bash


ACTION=$1
COUNT=$2

case  $ACTION in 
	create)
	if ! [[ "$COUNT" =~ ^[0-9]+$ ]]; then 
		echo "Error"
		exit 1
	fi
	echo "Creating $COUNT files ..."
	for i in $(seq 1 $COUNT); do 
		touch "${i}.tmp"
	done 
	echo "Done..."
	;;

	delete)
		echo "Delete all .tmp"
		rm -f *.tmp
		echo "Done."

	;;

	*)
		echo "usage: $0 {create <number> | delete}"
		exti 1
	;;

esac 
