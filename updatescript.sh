#!/bin/bash
if [ "$(id -u)" != 0 ]; then
	echo "You are not root. Switching to root..."

	#Use "sudo" to execute the script as root
	sudo "$0" "$@"

	#exit the script after switching to root
	exit $?
fi
echo "Running auto update"
sleep 3
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade
