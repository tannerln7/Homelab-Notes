# Vaultwarden

Vaultwarden here is the active password manager deployment running in a Debian 12 Proxmox LXC on the `vaultwarden` host.

## Current deployment summary

| Item | Value |
| --- | --- |
| Hostname | `vaultwarden` |
| Platform | Proxmox LXC |
| OS | Debian GNU/Linux 12 Bookworm |
| Current version at collection time | `1.35.4` |
| Service user / group | `vaultwarden:vaultwarden` |
| Runtime address | `0.0.0.0:8443` |

## Key paths

| Path | Purpose |
| --- | --- |
| `/opt/vaultwarden` | Primary application directory |
| `/opt/vaultwarden/bin/vaultwarden` | Runtime binary |
| `/opt/vaultwarden/data` | Data directory |
| `/opt/vaultwarden/web-vault` | Deployed web-vault content |
| `/opt/vaultwarden/backups` | Backup storage |
| `/opt/vaultwarden/.env` | Main environment file |
| `/etc/vaultwarden/secret.env` | Optional secret override environment file |

## Key services and timers

| Unit | Purpose |
| --- | --- |
| `vaultwarden.service` | Main Vaultwarden application service |
| `vaultwarden-update.service` | Oneshot update runner |
| `vaultwarden-update.timer` | Weekly update scheduler |
| `vaultwarden-backup.service` | Oneshot backup runner |
| `vaultwarden-backup.timer` | Daily backup scheduler |

## Quick commands

```bash
systemctl status vaultwarden --no-pager
/opt/vaultwarden/bin/vaultwarden --version
systemctl list-timers --all | grep -Ei 'vault|warden|update|backup'
journalctl -u vaultwarden -n 120 --no-pager
ls -lh /opt/vaultwarden/backups
```

## Pages

- [Overview](overview.md)
- [Configuration](configuration.md)
- [Updates](updates.md)
- [Backup / Restore](backup-restore.md)
- [Scripts](scripts/index.md)
- [Changes](changes.md)
- [Notes](notes.md)