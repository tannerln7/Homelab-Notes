# Vaultwarden Systemd Units

## Unit summary

| Unit | Runtime path | Documentation copy | Purpose |
| --- | --- | --- | --- |
| `vaultwarden.service` | `/etc/systemd/system/vaultwarden.service` | `docs/services/vaultwarden/scripts/files/vaultwarden.service` | Main application service |
| `vaultwarden-update.service` | `/etc/systemd/system/vaultwarden-update.service` | `docs/services/vaultwarden/scripts/files/vaultwarden-update.service` | Oneshot updater |
| `vaultwarden-update.timer` | `/etc/systemd/system/vaultwarden-update.timer` | `docs/services/vaultwarden/scripts/files/vaultwarden-update.timer` | Weekly update schedule |
| `vaultwarden-backup.service` | `/etc/systemd/system/vaultwarden-backup.service` | `docs/services/vaultwarden/scripts/files/vaultwarden-backup.service` | Oneshot backup runner |
| `vaultwarden-backup.timer` | `/etc/systemd/system/vaultwarden-backup.timer` | `docs/services/vaultwarden/scripts/files/vaultwarden-backup.timer` | Daily backup schedule |

## Service behavior highlights

- `vaultwarden.service` runs `/opt/vaultwarden/bin/vaultwarden`.
- It loads `EnvironmentFile=-/opt/vaultwarden/.env` and `EnvironmentFile=-/etc/vaultwarden/secret.env`.
- It runs as `vaultwarden:vaultwarden` with `WorkingDirectory=/opt/vaultwarden`.
- It allows writes to `/opt/vaultwarden/data` and enables several hardening settings.
- `vaultwarden-update.service` runs `/usr/local/bin/vaultwarden-update.sh` as a oneshot job.
- `vaultwarden-backup.service` runs `/usr/local/bin/vaultwarden-backup.sh` as a oneshot job.

## Schedule summary

- `vaultwarden-update.timer`: Fridays at 04:00, `Persistent=true`.
- `vaultwarden-backup.timer`: daily at 03:00, `Persistent=true`.

## Common commands

```bash
systemctl daemon-reload
systemctl enable --now vaultwarden.service
systemctl enable --now vaultwarden-update.timer
systemctl enable --now vaultwarden-backup.timer
systemctl list-timers --all | grep -Ei 'vault|warden|update|backup'
systemctl status vaultwarden --no-pager
systemctl status vaultwarden-update.timer --no-pager
systemctl status vaultwarden-backup.timer --no-pager
journalctl -u vaultwarden -n 120 --no-pager
journalctl -u vaultwarden-update.service -n 120 --no-pager
journalctl -u vaultwarden-backup.service -n 120 --no-pager
```

## Actual unit contents

### `vaultwarden.service`

```ini title="vaultwarden.service"
--8<-- "docs/services/vaultwarden/scripts/files/vaultwarden.service"
```

### `vaultwarden-update.service`

```ini title="vaultwarden-update.service"
--8<-- "docs/services/vaultwarden/scripts/files/vaultwarden-update.service"
```

### `vaultwarden-update.timer`

```ini title="vaultwarden-update.timer"
--8<-- "docs/services/vaultwarden/scripts/files/vaultwarden-update.timer"
```

### `vaultwarden-backup.service`

```ini title="vaultwarden-backup.service"
--8<-- "docs/services/vaultwarden/scripts/files/vaultwarden-backup.service"
```

### `vaultwarden-backup.timer`

```ini title="vaultwarden-backup.timer"
--8<-- "docs/services/vaultwarden/scripts/files/vaultwarden-backup.timer"
```