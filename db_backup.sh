#!/bin/bash

# Database access information
MYSQL_USER="USER"
MYSQL_PASSWORD="DB_PASSWORD"
DATABASE_NAME="DATABASE"
BACKUP_DIR="BACKUP Directory" # Your backup directory here, EX : /backup/db/

# Create Backup directory
mkdir -p $BACKUP_DIR

# Create backup file with timestamp
BACKUP_FILENAME="$DATABASE_NAME_$(date +'%Y%m%d%H%M%S').sql"

# Delete old file
# Find all .sql files in the directory
#files=($BACKUP_DIR/*.sql)

# Check if there are files in the directory
#if [ ${#files[@]} -eq 0 ]; then
#    echo "No .sql files found in the directory."
#    exit 0
#fi

# Function to extract timestamp from the filename
#extract_timestamp() {
#    filename=$(basename -- "$1")
#    # Extract the timestamp part of the filename (assuming it's in the format YYYYMMDDHHMMSS.sql)
#    timestamp="${filename%.*}"
#    echo "$timestamp"
#}

# Sort the files based on the extracted timestamps
#sorted_files=($(for file in "${files[@]}"; do
#    echo "$(extract_timestamp "$file") $file"
#done | sort | cut -d' ' -f2))

# Keep the most recent file and delete the older ones
#most_recent_file=${sorted_files[-1]}

#for file in "${sorted_files[@]}"; do
#    if [ "$file" != "$most_recent_file" ]; then
#        echo "Deleting older file: $file"
#        rm "$file"
#    fi
#done

#echo "Most recent file kept: $most_recent_file"

# Export database to backup directory with mysqldump command
mysqldump -u $MYSQL_USER -p$MYSQL_PASSWORD $DATABASE_NAME > $BACKUP_DIR/$BACKUP_FILENAME
