# Vaultwarden Updates

## Update policy

- Updates are handled by `vaultwarden-update.timer`.
- Schedule: Fridays at 04:00.
- Service: `vaultwarden-update.service`.
- Script: `/usr/local/bin/vaultwarden-update.sh`.
- The active updater handles both Vaultwarden server binary updates and web-vault updates/deployment.
- If both server and web-vault are already current, the script exits cleanly with no action.

## Update behavior

- The script checks the latest server tag from `/usr/local/src/vaultwarden-src`.
- It builds the server with Cargo using the sqlite feature.
- It compares the installed version reported by `/opt/vaultwarden/bin/vaultwarden --version`.
- It verifies the selected server tag signature with `git tag -v`.
- It runs `/usr/local/bin/vaultwarden-backup.sh` before replacing the server binary.
- It creates rollback bundles under `/root/vaultwarden-rollbacks` and keeps eight bundles.
- It checks the latest web-vault tag from `/usr/local/src/vaultwarden-web-src` and builds/deploys the web-vault only when needed.
- It restarts `vaultwarden.service` and then runs `/usr/local/bin/vaultwarden-healthcheck.sh`.

## Useful commands

```bash
systemctl list-timers --all | grep -Ei 'vault|warden|update|backup'
systemctl start vaultwarden-update.service
systemctl status vaultwarden-update.service --no-pager
journalctl -u vaultwarden-update.service -n 120 --no-pager
/opt/vaultwarden/bin/vaultwarden --version
```

## Detailed references

- [Main update script](scripts/update-script.md)
- [Deploy web-vault helper](scripts/deploy-webvault.md)
- [Systemd units](scripts/systemd-units.md)
- [Backup / Restore](backup-restore.md)