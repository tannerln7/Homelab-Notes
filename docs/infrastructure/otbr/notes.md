# OTBR Notes

## Gotchas

- OTBR services may show up as generated systemd units from SysV init scripts.
- Keep `/etc/default/otbr-agent` backed up before major changes.

## Workarounds and habits

- Use the normal service-triggered update path for routine checks.
- Reserve `--force` rebuilds for deliberate maintenance.
- Verify `ot-ctl` state after major updates instead of assuming the router recovered cleanly.

## Things to verify later

- OTBR web UI URL, if any.
- Network ports in active use.
- Actual local override contents under `/etc/systemd/system/otbr-agent.service.d`.

## References

- Source tree: `/root/ot-br-posix`
- Update script: `/usr/local/sbin/update-otbr-from-source.sh`
- Update log: `/var/log/otbr-source-update.log`