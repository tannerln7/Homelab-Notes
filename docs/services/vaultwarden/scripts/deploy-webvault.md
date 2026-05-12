# Deploy Web Vault

## Summary

| Item | Value |
| --- | --- |
| Script name | `deploy-webvault.sh` |
| Runtime path | `/usr/local/bin/deploy-webvault.sh` |
| Documentation copy | `docs/services/vaultwarden/scripts/files/deploy-webvault.sh` |

## Purpose

This helper deploys a built web-vault tarball into `/opt/vaultwarden/web-vault`. It is called by the main updater rather than used as a standalone scheduled entry point.

## Paths and behavior

| Item | Value |
| --- | --- |
| Build tarball source | `/usr/local/src/vaultwarden-web-src/builds` |
| Destination path | `/opt/vaultwarden/web-vault` |
| Staging path | `/opt/vaultwarden/web-vault.new` |
| Old-version move-aside pattern | `/opt/vaultwarden/web-vault.old.<timestamp>` |

## Deployment flow

- Selects the latest `bw_web_v*.tar.gz` using version sort.
- Extracts into a staging directory.
- Locates the real web root by checking for `index.html`.
- Moves the old deployed web-vault aside with a timestamped `.old.*` suffix.
- Swaps the staged build into `/opt/vaultwarden/web-vault`.
- Sets ownership to `root:root` and applies `chmod 755` recursively.

## Notes

- This helper is called by [Vaultwarden update script](update-script.md).
- The current file content contains duplicate tar extraction lines. Preserve the actual content for now, but verify later whether that duplication is intentional or should be cleaned up.

## Actual script contents

```bash title="deploy-webvault.sh"
--8<-- "docs/services/vaultwarden/scripts/files/deploy-webvault.sh"
```