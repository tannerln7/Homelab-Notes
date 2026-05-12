# Vaultwarden Scripts And Automation

This section documents the active Vaultwarden scripts, systemd units, and sanitized environment file using copied documentation files under `scripts/files/`.

The files in `docs/services/vaultwarden/scripts/files/` are documentation copies sourced from `tmp/scripts/`. They are not the live runtime files inside the LXC.

## Runtime locations

| Item | Runtime path |
| --- | --- |
| Main updater | `/usr/local/bin/vaultwarden-update.sh` |
| Web-vault deploy helper | `/usr/local/bin/deploy-webvault.sh` |
| Backup script | `/usr/local/bin/vaultwarden-backup.sh` |
| Healthcheck script | `/usr/local/bin/vaultwarden-healthcheck.sh` |
| Main service | `/etc/systemd/system/vaultwarden.service` |
| Update service | `/etc/systemd/system/vaultwarden-update.service` |
| Update timer | `/etc/systemd/system/vaultwarden-update.timer` |
| Backup service | `/etc/systemd/system/vaultwarden-backup.service` |
| Backup timer | `/etc/systemd/system/vaultwarden-backup.timer` |
| Env file | `/opt/vaultwarden/.env` |

## Documentation copy locations

| Item | Documentation copy |
| --- | --- |
| Main updater | `docs/services/vaultwarden/scripts/files/vaultwarden-update.sh` |
| Web-vault deploy helper | `docs/services/vaultwarden/scripts/files/deploy-webvault.sh` |
| Backup script | `docs/services/vaultwarden/scripts/files/vaultwarden-backup.sh` |
| Healthcheck script | `docs/services/vaultwarden/scripts/files/vaultwarden-healthcheck.sh` |
| Main service | `docs/services/vaultwarden/scripts/files/vaultwarden.service` |
| Update service | `docs/services/vaultwarden/scripts/files/vaultwarden-update.service` |
| Update timer | `docs/services/vaultwarden/scripts/files/vaultwarden-update.timer` |
| Backup service | `docs/services/vaultwarden/scripts/files/vaultwarden-backup.service` |
| Backup timer | `docs/services/vaultwarden/scripts/files/vaultwarden-backup.timer` |
| Sanitized env file | `docs/services/vaultwarden/scripts/files/vaultwarden.env` |

## Quick usage

```bash
systemctl start vaultwarden-update.service
systemctl start vaultwarden-backup.service
systemctl list-timers --all | grep -Ei 'vault|warden|update|backup'
/opt/vaultwarden/bin/vaultwarden --version
journalctl -u vaultwarden-update.service -n 120 --no-pager
```

## Pages

- [Update script](update-script.md)
- [Deploy web-vault helper](deploy-webvault.md)
- [Backup script](backup-script.md)
- [Healthcheck](healthcheck.md)
- [Systemd units](systemd-units.md)
- [Environment](environment.md)