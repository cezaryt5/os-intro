#!/bin/bash

GREP_OPTS=""
INPUT_FILE=""
OUTPUT_FILE=""
PATTERN=""

while getopts "i:o:p:Cn" opt; do 
	case $opt in 
		i) INPUT_FILE=$OPTARGS ;;
		o) OUTPUT_FILE=$OPTARGS ;;
		p) PATTERN=$OPTARGS ;;
		C) GREP_OPTS="$GREP_OPTS" ;;
		n) GREP_OPTS="$GREP_OPTS -n" ;;
		\?) echo "invalid option: -$OPTARG" >&2; exit 1 ;;
	esac
done

if [[ ! "$GREP_OPTS " =~ " -C " ]]; then 
	GREP_OPTS="$GREP_OPTS -i"
fi

if [ -z "$PATTERN" ]; then 
	echo "Error: pattern must be specified"
	exit 1
fi


CMD="grep $GREP_OPTS '$PATTERN' '$INPUT_FILE'"



if [ -n "$OUTPUT_FILE" ]; then 
	eval "$CMD > '$OUTPUT_FILE'"
	echo "Output written to $OUTPUT_FILE"
else 
	eval "$CMD"
fi
