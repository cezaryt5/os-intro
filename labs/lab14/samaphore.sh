#!/bin/bash

# variables

t1=5
t2=3
sem_file="/tmp/semaphore.lock"


# our function 
wait_for_semaphore() {
	echo "Wainting for the resource..."
	while [ -f "$sem_file" ] && [ $t1 -gt 0  ]; do
		sleep 1
		((t1--))
	done
	if [ ! -f "$sem_file" ]; then 
		touch "$sem_file"
		echo "Process captured resouces"
		return 0
	else
		echo " Couldnt capture the resouces"
		exit 1
	fi
}

# capturing resources 
wait_for_semaphore

# usinng the resources
echo "Used resource ($$) in $t2 sec.."
sleep $t2

# freeing resourcces

rm "$sem_file"
echo "Resourcees freed $$" 
