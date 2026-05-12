# OTBR Updates

## Update flow

The source update workflow checks the Git repository and only rebuilds when upstream has changed.

- Scheduled update check: Fridays at 04:00.
- Timer jitter: `RandomizedDelaySec=20m`.
- Avoid unattended forced rebuilds.

## Manual commands

Force a rebuild manually:

```bash
/usr/local/sbin/update-otbr-from-source.sh --force
```

Run the normal systemd-triggered update check:

```bash
systemctl start otbr-source-update.service
```

Check the timer state:

```bash
systemctl list-timers --all | grep -i otbr
```

## Logs

```bash
journalctl -u otbr-source-update.service -n 120 --no-pager
tail -n 120 /var/log/otbr-source-update.log
```

## Verification

- Confirm the update result in the service journal and log file.
- Verify `ot-ctl` state after major updates.
- If the update touched radio-side components, document RCP firmware changes separately.