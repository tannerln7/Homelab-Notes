#!/bin/bash
set -e

DATA_DIR="/opt/vaultwarden/data"
BACKUP_DIR="/opt/vaultwarden/backups"
DATE="$(date +%F-%H%M)"

mkdir -p "$BACKUP_DIR"

sqlite3 "$DATA_DIR/db.sqlite3" ".backup '$BACKUP_DIR/db-$DATE.sqlite3'"
tar -czf "$BACKUP_DIR/files-$DATE.tar.gz" -C "$DATA_DIR" attachments sends 2>/dev/null || true

find "$BACKUP_DIR" -type f -mtime +14 -delete