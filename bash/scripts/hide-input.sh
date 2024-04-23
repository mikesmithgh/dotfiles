#!/usr/bin/env bash

# this script hides/prevents user input
# this could be useful to call in a larger script
# that has periods of time they want
# to prevent unwanted input

hideinput() {
	if [ -t 0 ]; then
		stty -echo -icanon time 0 min 0
	fi
}

cleanup() {
	if [ -t 0 ]; then
		stty sane
	fi
}

trap cleanup EXIT
trap hideinput CONT
hideinput
while true; do
	read -r line
	sleep 2073600
done
echo
