# Vaultwarden Changes

## 2026-05-12 — Add initial Vaultwarden documentation set

### Changed
- Created the initial Vaultwarden documentation section for the active Proxmox LXC deployment.
- Copied the active scripts, systemd units, timers, and sanitized env file into `docs/services/vaultwarden/scripts/files/` as documentation copies.
- Documented the update and backup timers, the main updater, the deploy-webvault helper, the backup script, and the healthcheck script.
- Intentionally excluded any deprecated or removed web-only update script because the active updater already handles both server and web-vault updates.

### Reason
- Keep the current active deployment documented in one place with canonical copied file contents and practical operating notes.

### Files / paths touched
- `docs/services/vaultwarden/`
- `docs/services/vaultwarden/scripts/`
- `docs/services/vaultwarden/scripts/files/`
- `mkdocs.yml`
- `docs/services/index.md`

### Commands used
```bash
mkdocs build
```

### Notes
- The copied files under `docs/services/vaultwarden/scripts/files/` are sanitized documentation copies sourced from `tmp/scripts/`.
- Runtime files and secrets were documented, not changed.