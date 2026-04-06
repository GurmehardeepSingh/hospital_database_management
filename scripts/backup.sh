#!/bin/bash

DB_NAME="hms_db"
USER="root"

DATE=$(date +%F_%H-%M-%S)

BACKUP_DIR="../backups"
LOG_FILE="../logs/backup.log"

S3_BUCKET="s3://hms-db-backup-gds"

PASSWORD="$1"

mkdir -p $BACKUP_DIR

echo "Backup started $(date)" >> "$LOG_FILE"

# Step 1: Dump DB
mysqldump -u "$USER" -p "$DB_NAME" > "$BACKUP_DIR/backup_$DATE.sql"

# Step 2: Compress
gzip "$BACKUP_DIR/backup_$DATE.sql"

# Step 3: Encrypt
openssl enc -aes-256-cbc -salt \
-in "$BACKUP_DIR/backup_$DATE.sql.gz" \
-out "$BACKUP_DIR/backup_$DATE.sql.gz.enc" \
-k "$PASSWORD"

# Step 4: Upload to S3
aws s3 cp "$BACKUP_DIR/backup_$DATE.sql.gz.enc" "$S3_BUCKET"

if [ $? -eq 0 ]
then
echo "Upload SUCCESS $(date)" >> "$LOG_FILE"
else
echo "Upload FAILED $(date)" >> "$LOG_FILE"
fi

# Step 5: Cleanup local temp files
rm "$BACKUP_DIR/backup_$DATE.sql.gz"

# Step 6: Retention cleanup
find $BACKUP_DIR -type f -mtime +7 -delete

echo "Backup finished $(date)" >> "$LOG_FILE"
