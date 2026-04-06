#!/bin/bash

DB_NAME="hms_db"
USER="root"

S3_BUCKET="s3://hms-db-backup-gds"

PASSWORD=$1

LOG_FILE="../logs/restore.log"

FILE=$2

echo "Restore started $(date)" >> "$LOG_FILE"

# Step 1: Download from S3
aws s3 cp "$S3_BUCKET/$FILE" ../backups/

# Step 2: Decrypt
openssl enc -d -aes-256-cbc \
-in "../backups/$FILE" \
-out "../backups/restore.sql.gz" \
-k "$PASSWORD"

# Step 3: Unzip
gunzip "../backups/restore.sql.gz"

# Step 4: Restore DB
mysql -u "$USER" -p "$DB_NAME" < "../backups/restore.sql"

if [ $? -eq 0 ]
then
echo "Restore SUCCESS $(date)" >> "$LOG_FILE"
else
echo "Restore FAILED $(date)" >> "$LOG_FILE"
fi

echo "Restore completed"
