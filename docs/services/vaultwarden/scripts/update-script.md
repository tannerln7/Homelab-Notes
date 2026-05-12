# Vaultwarden Update Script

## Summary

| Item | Value |
| --- | --- |
| Script name | `vaultwarden-update.sh` |
| Runtime path | `/usr/local/bin/vaultwarden-update.sh` |
| Documentation copy | `docs/services/vaultwarden/scripts/files/vaultwarden-update.sh` |

## Purpose

This is the active scheduled updater for Vaultwarden. It is responsible for both the server binary update path and the web-vault update/deployment path.

## High-level behavior

- Checks server tags in `/usr/local/src/vaultwarden-src`.
- Compares the installed version from `/opt/vaultwarden/bin/vaultwarden --version`.
- Verifies the selected server tag with `git tag -v`.
- Builds the server with Cargo using the sqlite feature.
- Runs `/usr/local/bin/vaultwarden-backup.sh` before replacing the binary.
- Creates rollback bundles under `/root/vaultwarden-rollbacks` and keeps eight bundles.
- Restarts `vaultwarden.service` and then runs `/usr/local/bin/vaultwarden-healthcheck.sh`.
- Checks web-vault tags in `/usr/local/src/vaultwarden-web-src`, builds with `make full`, and deploys through `/usr/local/bin/deploy-webvault.sh` when needed.
- Exits cleanly if both the server and web-vault are already current.

## Server update flow

1. Fetch tags from `/usr/local/src/vaultwarden-src`.
2. Decide whether a newer server tag exists.
3. Check out the target tag and verify its signature.
4. Build the release binary.
5. Run the backup script.
6. Create a rollback bundle under `/root/vaultwarden-rollbacks`.
7. Stop `vaultwarden.service`, install the new binary, start the service, and run the healthcheck.

## Web-vault update flow

1. Fetch tags from `/usr/local/src/vaultwarden-web-src`.
2. Compare the current deployed web-vault version from `/opt/vaultwarden/web-vault/version.json`.
3. If a newer tag exists, build with `make full`.
4. Call `/usr/local/bin/deploy-webvault.sh` to stage and swap the deployed web-vault.

## Backup and rollback behavior

- Runs `/usr/local/bin/vaultwarden-backup.sh` before the server binary is replaced.
- Creates rollback tarballs under `/root/vaultwarden-rollbacks`.
- Keeps the eight newest rollback bundles and removes older ones.

## Healthcheck behavior

- Runs `/usr/local/bin/vaultwarden-healthcheck.sh` after restarting the main service.

## Usage

Manual run:

```bash
/usr/local/bin/vaultwarden-update.sh
```

Scheduled run:

```bash
systemctl start vaultwarden-update.service
```

## Important paths

| Path | Purpose |
| --- | --- |
| `/usr/local/src/vaultwarden-src` | Vaultwarden server source repo |
| `/usr/local/src/vaultwarden-web-src` | Web-vault source repo |
| `/opt/vaultwarden/bin/vaultwarden` | Installed runtime binary |
| `/opt/vaultwarden/web-vault` | Deployed web-vault |
| `/root/vaultwarden-rollbacks` | Rollback bundle storage |

## Actual script contents

```bash title="vaultwarden-update.sh"
--8<-- "docs/services/vaultwarden/scripts/files/vaultwarden-update.sh"
```