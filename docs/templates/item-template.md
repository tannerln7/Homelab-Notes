# Item Template

Use this template when creating a new documented item under one of the main categories.

## Suggested folder layout

```text
docs/<category>/<item-name>/
  index.md
  overview.md
  configuration.md
  updates.md
  scripts.md
  changes.md
  notes.md
```

## `index.md`

```markdown
# <Item Name>

Short summary of what it is and why it exists.

## Quick reference

| Item | Value |
| --- | --- |
| Runs on | <host / VM / LXC / device> |
| Main path | `<important path>` |
| Main service | `<service name>` |

## Pages

- [Overview](overview.md)
- [Configuration](configuration.md)
- [Updates](updates.md)
- [Scripts](scripts.md)
- [Changes](changes.md)
- [Notes](notes.md)
```

## `overview.md`

```markdown
# <Item Name> Overview

## Purpose

What this system does.

## Deployment context

Where it runs or physically lives.

## Important paths and services

- `<path>`
- `<service>`

## Related items

- `<related item>`
```

## `configuration.md`

```markdown
# <Item Name> Configuration

## Key paths

| Path | Purpose |
| --- | --- |
| `<path>` | `<what lives here>` |

## Services and timers

- `<service>`
- `<timer>`

## Notes

- Anything that should not be overwritten.
```

## `updates.md`

```markdown
# <Item Name> Updates

## Update flow

- Manual or scheduled.
- Exact command if known.

## Logs

```bash
journalctl -u <service> -n 120 --no-pager
```

## Verification

- What to check after updates.
```

## `scripts.md`

See the reusable structure in [Script Template](script-template.md).

## `changes.md`

See the exact format in [Change Log Template](change-log-template.md).

## `notes.md`

See the starter headings in [Notes Template](notes-template.md).