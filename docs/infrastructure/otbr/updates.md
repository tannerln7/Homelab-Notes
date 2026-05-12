# OTBR Updates

## Update policy

- The source update workflow checks the upstream Git repository before doing any rebuild work.
- Scheduled runs should only rebuild and reinstall when upstream has changed.
- Unattended forced rebuilds should be avoided.

## Scheduled behavior

- Scheduled update check: Fridays at 04:00.
- Timer jitter: `RandomizedDelaySec=20m`.
- Scheduled runs should use the normal service path, not `--force`.

## Manual commands

Run the normal service-triggered update check:

```bash
systemctl start otbr-source-update.service
```

Force a rebuild manually:

```bash
/usr/local/sbin/update-otbr-from-source.sh --force
```

Check the timer state:

```bash
systemctl list-timers --all | grep -i otbr
```

Verify OTBR after a major update:

```bash
ot-ctl state
```

## Logs

```bash
journalctl -u otbr-source-update.service -n 120 --no-pager
tail -n 120 /var/log/otbr-source-update.log
```

## Safety notes

- Do not put `--force` behind the timer or any unattended workflow.
- Keep OTBR agent and web defaults backed up before major rebuilds.
- If the update touched radio-side components, document RCP firmware changes separately.

## Detailed references

- [Scripts and automation index](scripts/index.md)
- [Main update script](scripts/update-otbr-from-source.md)
- [Systemd service and timer](scripts/systemd-units.md)
- [Helper commands](scripts/helper-commands.md)