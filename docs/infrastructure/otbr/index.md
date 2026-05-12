# OTBR

OTBR is documented here as an OpenThread Border Router running in a Debian LXC, built from source and maintained with a source update workflow.

## Quick reference

| Item | Value |
| --- | --- |
| Runs in | Debian LXC |
| Repository clone path | `/root/ot-br-posix` |
| Update script | `/usr/local/sbin/update-otbr-from-source.sh` |
| Update log | `/var/log/otbr-source-update.log` |
| Backup path | `/var/backups/otbr-source-update` |
| Source update service | `otbr-source-update.service` |
| Source update timer | `otbr-source-update.timer` |
| Scheduled check | Fridays at 04:00 |
| Timer delay | `RandomizedDelaySec=20m` |

## Pages

- [Overview](overview.md)
- [Configuration](configuration.md)
- [Updates](updates.md)
- [Scripts](scripts/index.md)
- [Changes](changes.md)
- [Notes](notes.md)

!!! note
	Major OTBR updates should include an `ot-ctl` state check afterward.

!!! warning
	Document RCP firmware changes separately from the OTBR host-side notes.