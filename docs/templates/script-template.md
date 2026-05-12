# Script Template

Use this when documenting a script inside an item page or when creating a standalone script page.

```markdown
# <Script Name>

## Summary

- Purpose: <what it does>
- Location: `<path>`
- Runs as: `<user>`
- Safe to run manually: yes / no / unknown

## Arguments

| Argument | Meaning |
| --- | --- |
| `<flag>` | `<description>` |

## Usage

```bash
<path> <args>
```

## Logs

```bash
journalctl -u <service> -n 120 --no-pager
tail -n 120 <log path>
```

## Related units or automation

- `<service>`
- `<timer>`

## Files touched

- `<path>`

## Full script content

Unknown / not documented yet.
```

If the script content is worth embedding later, paste the real script only after verifying it and remove any secrets first.