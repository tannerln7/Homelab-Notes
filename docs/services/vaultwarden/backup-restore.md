# Vaultwarden Backup And Restore

## Backup summary

| Item | Value |
| --- | --- |
| Backup script | `/usr/local/bin/vaultwarden-backup.sh` |
| Backup timer | `vaultwarden-backup.timer` |
| Backup service | `vaultwarden-backup.service` |
| Schedule | Daily at 03:00 |
| Backup directory | `/opt/vaultwarden/backups` |

## Backup outputs

- Database backups: `db-YYYY-MM-DD-HHMM.sqlite3`
- File archives: `files-YYYY-MM-DD-HHMM.tar.gz`

## What gets backed up

- SQLite database via `sqlite3 .backup`
- Attachments under `/opt/vaultwarden/data/attachments`
- Sends under `/opt/vaultwarden/data/sends`

## Retention

- Backup files older than 14 days are deleted.

## Important data files

- `/opt/vaultwarden/data/db.sqlite3`
- `/opt/vaultwarden/data/db.sqlite3-shm`
- `/opt/vaultwarden/data/db.sqlite3-wal`
- `/opt/vaultwarden/data/rsa_key.pem`

At collection time:

- `/opt/vaultwarden/data/rsa_key.pub.pem` was missing.
- `/opt/vaultwarden/data/config.json` was missing.

!!! warning
    Do not commit database files, attachment archives, or key material into this repository.

## Verification commands

```bash
systemctl status vaultwarden-backup.timer --no-pager
systemctl start vaultwarden-backup.service
ls -lh /opt/vaultwarden/backups
```

## Restore notes

- The collected active scripts document backup behavior, not a full tested restore workflow.
- Before relying on recovery, verify that recent database and file-archive backups exist in `/opt/vaultwarden/backups`.
- TODO: add a tested restore procedure after one has been performed and verified.

## Detailed references

- [Backup script](scripts/backup-script.md)
- [Systemd units](scripts/systemd-units.md)