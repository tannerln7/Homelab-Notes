# OTBR Changes

## 2026-05-12 — Restructure OTBR script and unit documentation

### Changed
- Copied the actual OTBR update script, service unit, timer unit, and helper wrapper into `docs/infrastructure/otbr/scripts/files/` as documentation copies.
- Split the old single OTBR scripts page into focused pages for the main update script, systemd units, and helper commands.
- Removed duplicated script and unit detail from the OTBR updates and configuration pages.
- Enabled MkDocs snippets so the copied source files can be rendered directly in the docs.

### Reason
- Keep the canonical script and unit contents in one place inside the documentation tree.
- Reduce duplication between OTBR pages while keeping the runtime paths and operational notes easy to find.

### Files / paths touched
- `mkdocs.yml`
- `docs/infrastructure/otbr/scripts/`
- `docs/infrastructure/otbr/scripts/files/`
- `docs/infrastructure/otbr/updates.md`
- `docs/infrastructure/otbr/configuration.md`

### Commands used
```bash
mkdocs build
```

### Notes
- Runtime install locations were documented, not changed.
- The copied files under `docs/infrastructure/otbr/scripts/files/` are documentation copies sourced from `tmp/scripts/`.

## 2026-05-12 — Setup source update automation

### Changed
- Added a source update workflow around `/usr/local/sbin/update-otbr-from-source.sh`.
- Added `otbr-source-update.service` and `otbr-source-update.timer` for scheduled update checks.
- Recorded the log path and backup path used by the workflow.

### Reason
- Keep the OTBR source build current without rebuilding unnecessarily.
- Make update checks repeatable and easier to audit later.

### Files / paths touched
- `/root/ot-br-posix`
- `/usr/local/sbin/update-otbr-from-source.sh`
- `/var/log/otbr-source-update.log`
- `/var/backups/otbr-source-update`
- `/etc/default/otbr-agent`

### Commands used
```text
Unknown / not documented yet.
```

### Notes
- Scheduled update checks run on Fridays at 04:00 with `RandomizedDelaySec=20m`.
- Scheduled runs check Git and only rebuild when upstream has changed.
- Avoid unattended forced rebuilds.
- Verify `ot-ctl` state after major updates.
- Document RCP firmware changes separately.