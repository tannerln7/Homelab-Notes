# Vaultwarden Environment

## Summary

| Item | Value |
| --- | --- |
| Runtime path | `/opt/vaultwarden/.env` |
| Optional secret env path | `/etc/vaultwarden/secret.env` |
| Documentation copy | `docs/services/vaultwarden/scripts/files/vaultwarden.env` |

## Purpose

The env file is the current source-of-truth configuration layer for this deployment. `config.json` was not present at `/opt/vaultwarden/data/config.json` at collection time.

## Important settings

| Setting | Value |
| --- | --- |
| `ADMIN_TOKEN` | `<REDACTED>` |
| `ROCKET_ADDRESS` | `0.0.0.0` |
| `ROCKET_PORT` | `8443` |
| `ROCKET_TLS` | `certs=/opt/vaultwarden/tls/origin.pem`, `key=/opt/vaultwarden/tls/origin.key` |
| `DATA_FOLDER` | `/opt/vaultwarden/data` |
| `DATABASE_MAX_CONNS` | `10` |
| `WEB_VAULT_FOLDER` | `/opt/vaultwarden/web-vault` |
| `WEB_VAULT_ENABLED` | `true` |
| `DOMAIN` | `<REDACTED_URL>` |
| `IP_HEADER` | `X-Forwarded-For` |
| `SHOW_PASSWORD_HINT` | `false` |
| `SIGNUPS_ALLOWED` | `false` |
| `INVITATIONS_ALLOWED` | `false` |
| `EMAIL_CHANGE_ALLOWED` | `false` |
| `SENDS_ALLOWED` | `true` |
| `TRASH_AUTO_DELETE_DAYS` | `30` |
| `ADMIN_SESSION_LIFETIME` | `20` |
| `PUSH_ENABLED` | `true` |
| `PUSH_INSTALLATION_ID` | `<REDACTED>` |
| `PUSH_INSTALLATION_KEY` | `<REDACTED>` |

!!! warning
    Do not commit real `ADMIN_TOKEN`, push keys, SMTP credentials, or any other secrets. The file included here is sanitized.

## Actual sanitized env contents

```env title="vaultwarden.env"
--8<-- "docs/services/vaultwarden/scripts/files/vaultwarden.env"
```