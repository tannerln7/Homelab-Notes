# OTBR Configuration

## Configuration files and overrides

| Path | Purpose |
| --- | --- |
| `/etc/systemd/system/otbr-agent.service.d` | `otbr-agent` override directory |
| `/etc/default/otbr-agent` | OTBR agent defaults file that should be backed up before major edits |
| `/etc/default/otbr-web` | OTBR web defaults file, if present |

## Service notes

- `otbr-agent.service`
- `otbr-web.service`
- `otbr-firewall.service`
- `otbr-nat44.service`

## Notes

- OTBR service units may be generated from SysV init scripts.
- Keep `/etc/default/otbr-agent` backed up.
- Document RCP firmware changes separately from host-side configuration changes.

## Related documentation

- [OTBR updates](updates.md)
- [OTBR scripts and units](scripts/index.md)