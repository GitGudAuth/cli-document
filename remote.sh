#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: remote <IP_ADDRESS:PORT> <PASSWORD> [USERNAME]"
    exit 1
fi

IP_PORT="$1"
PASSWORD="$2"

# Default to 'root' if no username is provided
USERNAME="${3:-root}"

# Check if a port is specified
if [[ "$IP_PORT" == *:* ]]; then
    IP=$(echo "$IP_PORT" | cut -d ':' -f 1)
    PORT=$(echo "$IP_PORT" | cut -d ':' -f 2)
else
    IP="$IP_PORT"
    PORT=22  # Default port
fi

echo "Connecting to $IP on port $PORT as $USERNAME..."

# Run the SSH connection with sshpass
sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no -p "$PORT" "$USERNAME"@"$IP"
