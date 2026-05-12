# OTBR Scripts

## Source update script

- Path: `/usr/local/sbin/update-otbr-from-source.sh`
- Purpose: check the OTBR Git checkout and rebuild from source when upstream has changed.
- Related units: `otbr-source-update.service`, `otbr-source-update.timer`
- Log file: `/var/log/otbr-source-update.log`
- Backup path: `/var/backups/otbr-source-update`

## Known arguments

| Argument | Meaning |
| --- | --- |
| `--force` | Force a rebuild instead of waiting for an upstream change |

## Usage examples

Normal systemd-triggered update check:

```bash
systemctl start otbr-source-update.service
```

Forced rebuild:

```bash
/usr/local/sbin/update-otbr-from-source.sh --force
```

Check recent logs:

```bash
journalctl -u otbr-source-update.service -n 120 --no-pager
tail -n 120 /var/log/otbr-source-update.log
```

## Full script content

Unknown / not documented yet.

Add the real script later if it is useful to keep here, but do not invent or paraphrase its contents.