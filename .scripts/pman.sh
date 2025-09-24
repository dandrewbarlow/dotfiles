#! /bin/bash
# pman.sh
# written by Andrew Barlow

# DESCRIPTION:
# pman takes one argument, a program name, converts it's man page to a pdf,
# stores it in a temporary file, opens it in the default pdf reader, waits for
# that pdf reader to close, and then removes the temporary file.

if [ "$#" -ne 1 ]; then
	echo "Error: pman takes exactly 1 argument, a program name"
	exit
fi

tmp="$(mktemp)"

man -t "$1" | ps2pdf - > "$tmp"

xdg-open "$tmp" && echo "PDF Reader Launched"

pid="$(ps aux | grep -i "$tmp" | grep -v 'grep' | awk '{print $2}')"

if [ "$pid" != "" ]; then
	while [ -e "/proc/$pid" ]
	do
		sleep .6
	done
else
	echo "Error: Process not found"
fi

echo "Process Finished, removing tmp file"
rm "$tmp"
