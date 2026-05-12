# Update OTBR From Source

## Summary

| Item | Value |
| --- | --- |
| Script name | `update-otbr-from-source.sh` |
| Runtime path | `/usr/local/sbin/update-otbr-from-source.sh` |
| Documentation copy | `docs/infrastructure/otbr/scripts/files/update-otbr-from-source.sh` |
| Log path | `/var/log/otbr-source-update.log` |
| Backup directory | `/var/backups/otbr-source-update` |
| Repo path | `/root/ot-br-posix` |

## Purpose

This is the main OTBR maintenance script used for scheduled update checks and manual rebuilds.

## High-level behavior

- Parses `--force` / `--force-rebuild` and `--help`.
- Logs to `/var/log/otbr-source-update.log` while still printing output for manual runs.
- Uses a lock file to avoid overlapping runs.
- Fetches upstream Git state and exits early when the repository is already current unless forced.
- Backs up `/etc/default/otbr-agent` and `/etc/default/otbr-web` when present.
- Fast-forwards the OTBR repo, updates submodules, runs bootstrap and setup, reloads systemd, and restarts OTBR services.
- Checks `ot-ctl state` at the end as a quick verification step.

## Arguments

| Argument | Meaning |
| --- | --- |
| `--force` | Rebuild and reinstall even when upstream is already current |
| `--force-rebuild` | Same forced rebuild behavior as `--force` |
| `--help` | Show usage information |

## Usage

Normal manual run:

```bash
/usr/local/sbin/update-otbr-from-source.sh
```

Forced rebuild:

```bash
/usr/local/sbin/update-otbr-from-source.sh --force
```

Check the log:

```bash
tail -n 120 /var/log/otbr-source-update.log
```

Verify OTBR afterward:

```bash
ot-ctl state
```

## Backup behavior

- The script creates the backup directory if needed.
- It stores timestamped backups of `/etc/default/otbr-agent` and `/etc/default/otbr-web` when those files exist.

## Safety notes

- Avoid unattended forced rebuilds.
- Normal scheduled runs should rely on the default non-force behavior.
- Keep the OTBR agent defaults file backed up before making related config changes.

## What to verify afterward

- The update finished cleanly in the service journal or log file.
- `otbr-agent.service` restarted successfully.
- `ot-ctl state` reports a healthy post-update state.

## Actual script contents

```bash title="update-otbr-from-source.sh"
--8<-- "docs/infrastructure/otbr/scripts/files/update-otbr-from-source.sh"
```