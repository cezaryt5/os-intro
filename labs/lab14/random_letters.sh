#!/bin/bash

length=${1:-10}

generate_letter() {
	rand=$(( RANDOM % 26 ))
	printf "\\x$(printf %02x $((65 + rand)))"
}

result=""
for ((i=0; i<length; i++)); do	
	result+=$(generate_letter)
done

echo $result
