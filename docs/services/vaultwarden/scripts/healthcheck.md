# Vaultwarden Healthcheck

## Summary

| Item | Value |
| --- | --- |
| Script name | `vaultwarden-healthcheck.sh` |
| Runtime path | `/usr/local/bin/vaultwarden-healthcheck.sh` |
| Documentation copy | `docs/services/vaultwarden/scripts/files/vaultwarden-healthcheck.sh` |

## Purpose

This script performs the post-restart health check used by the main updater.

## Behavior

- Called by `/usr/local/bin/vaultwarden-update.sh` after restarting `vaultwarden.service`.
- Uses `ROCKET_PORT` with a fallback of `8080` inside the script.
- Checks the Vaultwarden health endpoint with redacted URLs in the sanitized documentation copy.

## Manual usage

```bash
/usr/local/bin/vaultwarden-healthcheck.sh
```

## Notes

- Healthcheck URL values are intentionally redacted in the docs.

## Actual script contents

```bash title="vaultwarden-healthcheck.sh"
--8<-- "docs/services/vaultwarden/scripts/files/vaultwarden-healthcheck.sh"
```