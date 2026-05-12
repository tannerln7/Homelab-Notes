# OTBR Systemd Units

## Purpose

The OTBR source update workflow uses one oneshot service and one timer:

- `otbr-source-update.service` runs the update script.
- `otbr-source-update.timer` schedules the recurring check.

## Paths

| Item | Runtime path | Documentation copy |
| --- | --- | --- |
| Service unit | `/etc/systemd/system/otbr-source-update.service` | `docs/infrastructure/otbr/scripts/files/otbr-source-update.service` |
| Timer unit | `/etc/systemd/system/otbr-source-update.timer` | `docs/infrastructure/otbr/scripts/files/otbr-source-update.timer` |

## Schedule and behavior

- Timer schedule: Fridays at 04:00.
- Delay jitter: `RandomizedDelaySec=20m`.
- The timer should not use `--force`.
- Scheduled runs should check upstream state and only rebuild when the repo has changed.

Using `--force` from the timer would turn the weekly check into an unconditional rebuild, which is the behavior to avoid.

## Common commands

Reload systemd after unit changes:

```bash
systemctl daemon-reload
```

Enable and start the timer:

```bash
systemctl enable --now otbr-source-update.timer
```

Check timers:

```bash
systemctl list-timers --all | grep -i otbr
```

Start the service manually:

```bash
systemctl start otbr-source-update.service
```

Check service and timer status:

```bash
systemctl status otbr-source-update.service --no-pager
systemctl status otbr-source-update.timer --no-pager
```

Read recent logs:

```bash
journalctl -u otbr-source-update.service -n 120 --no-pager
```

Disable the timer:

```bash
systemctl disable --now otbr-source-update.timer
```

## Actual service unit contents

```ini title="otbr-source-update.service"
--8<-- "docs/infrastructure/otbr/scripts/files/otbr-source-update.service"
```

## Actual timer unit contents

```ini title="otbr-source-update.timer"
--8<-- "docs/infrastructure/otbr/scripts/files/otbr-source-update.timer"
```