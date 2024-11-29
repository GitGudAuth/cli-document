#!/bin/bash

# Directory to back up
SOURCE_DIR="/home"

# Backup destination directory
BACKUP_DIR="/backup/backup-source"

# Date format for the backup file
DATE=$(date +'%Y%m%d%H%M%S')

# Backup file name
BACKUP_FILE="backup_$DATE.zip"

# Create the backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Create the backup
zip -r "$BACKUP_DIR/$BACKUP_FILE" "$SOURCE_DIR"

# Check if the backup was successful
if [ $? -eq 0 ]; then
    echo "Backup created successfully: $BACKUP_DIR/$BACKUP_FILE"
else
    echo "Backup failed!"
    exit 1
fi

# Find and delete older backup files, keeping only the most recent one
cd "$BACKUP_DIR" || exit

# List all backup files sorted by modification time, keep the most recent, delete the rest
ls -tp | grep -v '/$' | grep -E 'backup_[0-9]{14}.zip' | tail -n +2 | xargs -I {} rm -- {}

echo "Old backups deleted, only the most recent one is kept."
