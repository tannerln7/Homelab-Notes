# Vaultwarden Overview

## Deployment

- Hostname: `vaultwarden`
- Environment: Proxmox LXC
- OS: Debian GNU/Linux 12 Bookworm
- Main service: `vaultwarden.service`
- Current known Vaultwarden version at collection time: `1.35.4`

## Runtime layout

| Item | Value |
| --- | --- |
| Binary path | `/opt/vaultwarden/bin/vaultwarden` |
| Working directory | `/opt/vaultwarden` |
| Data directory | `/opt/vaultwarden/data` |
| Web-vault directory | `/opt/vaultwarden/web-vault` |
| Backups | `/opt/vaultwarden/backups` |

## Access model

- Vaultwarden listens on `0.0.0.0:8443`.
- UFW allows `8443/tcp` only from `192.168.1.243`.
- UFW allows `22/tcp` from `192.168.1.0/24`.
- Default incoming firewall policy is deny.

## Important caveats

- Do not commit real secrets, tokens, push keys, or SMTP credentials.
- `config.json` was not present at `/opt/vaultwarden/data/config.json` at collection time, so env-file configuration is the current source of truth.
- Backup-critical data lives under `/opt/vaultwarden/data`.
- Main data files observed at collection time included:
  - `/opt/vaultwarden/data/db.sqlite3`
  - `/opt/vaultwarden/data/db.sqlite3-shm`
  - `/opt/vaultwarden/data/db.sqlite3-wal`
  - `/opt/vaultwarden/data/rsa_key.pem`
- `/opt/vaultwarden/data/rsa_key.pub.pem` was missing at collection time.