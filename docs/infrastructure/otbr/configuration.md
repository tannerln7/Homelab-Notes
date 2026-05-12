# OTBR Configuration

## Key paths

| Path | Purpose |
| --- | --- |
| `/root/ot-br-posix` | Local OTBR source clone |
| `/usr/local/sbin/update-otbr-from-source.sh` | Source update script |
| `/var/log/otbr-source-update.log` | Source update log |
| `/var/backups/otbr-source-update` | Backup location used by the source update workflow |
| `/etc/systemd/system/otbr-agent.service.d` | `otbr-agent` override directory |
| `/etc/default/otbr-agent` | OTBR agent defaults file that should be backed up before major edits |

## Services and timers

- `otbr-agent.service`
- `otbr-web.service`
- `otbr-firewall.service`
- `otbr-nat44.service`
- `otbr-source-update.service`
- `otbr-source-update.timer`

## Notes

- OTBR service units may be generated from SysV init scripts.
- Keep `/etc/default/otbr-agent` backed up.
- Document RCP firmware changes separately from host-side configuration changes.

## Unknown / not documented yet

- OTBR URLs and ports.
- The exact contents of local service overrides.