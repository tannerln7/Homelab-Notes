# Vaultwarden Configuration

## Configuration paths

| Path | Purpose |
| --- | --- |
| `/opt/vaultwarden/.env` | Main Vaultwarden environment file |
| `/etc/vaultwarden/secret.env` | Optional secret-only environment override |
| `/opt/vaultwarden/tls/origin.pem` | TLS certificate path referenced by the env file |
| `/opt/vaultwarden/tls/origin.key` | TLS key path referenced by the env file |
| `/opt/vaultwarden/data` | Runtime data directory |
| `/opt/vaultwarden/web-vault` | Deployed web-vault assets |
| `/opt/vaultwarden/backups` | Backup output directory |

## Service hardening summary

`vaultwarden.service` runs the binary as `vaultwarden:vaultwarden`, uses `/opt/vaultwarden` as its working directory, and limits writes to `/opt/vaultwarden/data`.

Hardening enabled in the unit includes:

- `PrivateTmp=true`
- `PrivateDevices=true`
- `ProtectHome=true`
- `ProtectSystem=strict`
- `DevicePolicy=closed`
- `ProtectControlGroups=yes`
- `ProtectKernelModules=yes`
- `ProtectKernelTunables=yes`
- `RestrictNamespaces=yes`
- `RestrictRealtime=yes`
- `MemoryDenyWriteExecute=yes`
- `LockPersonality=yes`

## Firewall summary

- Default incoming policy: deny.
- `8443/tcp` allowed only from `192.168.1.243`.
- `22/tcp` allowed from `192.168.1.0/24`.

## Related docs

- [Environment file details](scripts/environment.md)
- [Systemd units](scripts/systemd-units.md)
- [Updates](updates.md)
- [Backup / Restore](backup-restore.md)