# OTBR Scripts And Automation

This section documents the OTBR source update script, its systemd units, and the optional helper wrapper from copied documentation files under `scripts/files/`.

The files in `docs/infrastructure/otbr/scripts/files/` are documentation copies sourced from `tmp/scripts/`. They are not the live runtime install locations inside the Debian LXC.

## Runtime locations

| Item | Runtime path |
| --- | --- |
| Main update script | `/usr/local/sbin/update-otbr-from-source.sh` |
| Manual helper command | `/usr/local/bin/otbr-update-now` |
| Service unit | `/etc/systemd/system/otbr-source-update.service` |
| Timer unit | `/etc/systemd/system/otbr-source-update.timer` |
| Update log | `/var/log/otbr-source-update.log` |
| Backup directory | `/var/backups/otbr-source-update` |

## Documentation copy locations

| Item | Documentation copy |
| --- | --- |
| Update script | `docs/infrastructure/otbr/scripts/files/update-otbr-from-source.sh` |
| Service unit | `docs/infrastructure/otbr/scripts/files/otbr-source-update.service` |
| Timer unit | `docs/infrastructure/otbr/scripts/files/otbr-source-update.timer` |
| Helper wrapper | `docs/infrastructure/otbr/scripts/files/otbr-update-now.sh` |

## Quick usage

```bash
systemctl start otbr-source-update.service
/usr/local/sbin/update-otbr-from-source.sh --force
systemctl list-timers --all | grep -i otbr
tail -n 120 /var/log/otbr-source-update.log
ot-ctl state
```

## Pages

- [Main update script](update-otbr-from-source.md)
- [Systemd units](systemd-units.md)
- [Helper commands](helper-commands.md)