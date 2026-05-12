# OTBR Changes

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