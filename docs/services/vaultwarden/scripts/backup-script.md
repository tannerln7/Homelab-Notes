# Vaultwarden Backup Script

## Summary

| Item | Value |
| --- | --- |
| Script name | `vaultwarden-backup.sh` |
| Runtime path | `/usr/local/bin/vaultwarden-backup.sh` |
| Documentation copy | `docs/services/vaultwarden/scripts/files/vaultwarden-backup.sh` |
| Data directory | `/opt/vaultwarden/data` |
| Backup directory | `/opt/vaultwarden/backups` |

## Purpose

This script creates the active local backup set used by both the daily backup timer and the update workflow.

## Backup behavior

- Creates the backup directory if needed.
- Uses `sqlite3` with `.backup` to write a consistent SQLite backup.
- Archives `attachments` and `sends` into a timestamped tarball.
- Deletes backup files older than 14 days.

## Manual usage

```bash
/usr/local/bin/vaultwarden-backup.sh
```

## Actual script contents

```bash title="vaultwarden-backup.sh"
--8<-- "docs/services/vaultwarden/scripts/files/vaultwarden-backup.sh"
```