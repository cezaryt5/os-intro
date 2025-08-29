#!/bin/bash

gcc check_number.c -o check_number

if [ $? -ne 0 ]; then 
	echo "C program failed to compile."
	exit 1
fi 

./check_number

EXIT_STATUS=$?


case $EXIT_STATUS in
	0)echo "zero" ;;
	1)echo "positive" ;;
	2)echo "negative" ;; 
	*)echo "Unknown : $EXIT_STATUS" ;; 
esac

rm check_number
