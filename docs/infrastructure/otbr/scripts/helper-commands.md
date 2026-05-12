# OTBR Helper Commands

## Summary

| Item | Value |
| --- | --- |
| Helper wrapper | `otbr-update-now.sh` |
| Runtime path | `/usr/local/bin/otbr-update-now` |
| Documentation copy | `docs/infrastructure/otbr/scripts/files/otbr-update-now.sh` |

## Purpose

This helper wraps the main OTBR update script with `sudo` and forwards all arguments to it.

## Usage examples

Run a normal update check:

```bash
/usr/local/bin/otbr-update-now
```

Run a forced rebuild:

```bash
/usr/local/bin/otbr-update-now --force
```

Show help from the underlying update script:

```bash
/usr/local/bin/otbr-update-now --help
```

## Notes

- The copied documentation file keeps the source filename `otbr-update-now.sh` from `tmp/scripts/`.
- The intended runtime install path is `/usr/local/bin/otbr-update-now`.

## Actual helper contents

```bash title="otbr-update-now.sh"
--8<-- "docs/infrastructure/otbr/scripts/files/otbr-update-now.sh"
```