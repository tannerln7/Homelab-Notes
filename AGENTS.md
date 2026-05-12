# AGENTS.md

## Purpose of this repository

This repository is a personal documentation and operations notebook for homelab, infrastructure, services, applications, hardware, networking, scripts, workarounds, configuration details, and other easy-to-forget technical notes.

The repository is intended primarily for private/personal reference, not as a polished public documentation hub. Prioritize accuracy, organization, scanability, and long-term maintainability over marketing-style presentation.

The documentation should make it easy to answer questions like:

- What is this service, application, device, or infrastructure component?
- Where does it run or physically live?
- What files, paths, services, ports, timers, scripts, commands, or dependencies matter?
- How are updates, backups, rebuilds, restarts, or maintenance handled?
- What customizations, overrides, patches, or workarounds were applied?
- What changed, when, and why?
- What should not be forgotten next time this thing breaks, needs maintenance, or gets migrated?

Do not store secrets, passwords, private keys, API tokens, recovery keys, or sensitive credentials in this repository.

---

## Repository scope

This repository may document any technical item that is useful to remember later, including but not limited to:

- Infrastructure components
- Self-hosted services
- Applications
- Containers
- Virtual machines
- LXCs
- Hardware devices
- Networking equipment
- Automation jobs
- Scripts
- Build/update processes
- Configuration customizations
- Operational procedures
- Workarounds
- Troubleshooting notes
- Design decisions
- Migration notes
- Backup/restore notes

The structure should stay flexible enough to support many unrelated services and systems without forcing every item into one rigid format.

---

## Documentation framework

This repo uses MkDocs with Material for MkDocs.

Documentation pages live under:

```text
docs/
```

The main MkDocs configuration lives at:

```text
mkdocs.yml
```

The site should remain simple, static, and easy to edit in VSCode using Markdown files.

Avoid adding unnecessary frameworks, build systems, databases, frontend tooling, or complex dependencies unless explicitly requested.

---

## High-level organization

Use a hierarchical structure.

Expected top-level documentation sections:

```text
docs/
  index.md
  infrastructure/
  services/
  applications/
  networking/
  hardware/
  automation/
  scripts/
  templates/
```

Use the category that best matches the item being documented. If an item spans multiple categories, place the main documentation where it is most likely to be found later and link to it from related sections if needed.

Typical category usage:

- `infrastructure/` â foundational systems, hosts, LXCs, VMs, platforms, hypervisors, clusters, routers, border routers, storage foundations, core utilities.
- `services/` â self-hosted services, daemons, web services, databases, media services, password managers, monitoring services, and long-running server-side applications.
- `applications/` â user-facing applications, desktop/mobile/web apps, integrations, management tools, or app-specific notes.
- `networking/` â VLANs, firewall rules, DNS, DHCP, Wi-Fi, routing, switches, access points, VPNs, and network diagrams/notes.
- `hardware/` â physical devices, servers, appliances, embedded boards, accessories, repairs, firmware, and physical configuration notes.
- `automation/` â scheduled jobs, timers, update automations, CI/CD, Home Assistant automations, notification flows, and recurring workflows.
- `scripts/` â reusable scripts that are not tied to only one documented item, or an index of important scripts.
- `templates/` â reusable documentation templates.

Each documented item should usually live under one of these paths:

```text
docs/infrastructure/<item-name>/
docs/services/<item-name>/
docs/applications/<item-name>/
docs/networking/<item-name>/
docs/hardware/<item-name>/
docs/automation/<item-name>/
```

For example:

```text
docs/services/vaultwarden/
docs/infrastructure/otbr/
docs/networking/unifi/
docs/hardware/epyc-server/
docs/automation/source-update-jobs/
```

A typical item may contain pages like:

```text
index.md
overview.md
configuration.md
updates.md
scripts.md
changes.md
notes.md
```

Not every item needs every page. Use the pages that make sense, but keep naming consistent where practical.

---

## Page purposes

### `index.md`

The landing page for a category or item.

For an item, this should act as a quick summary and navigation page.

Include:

- What it is
- Why it exists
- Where it runs or physically lives
- Most important paths, services, ports, scripts, URLs, or commands
- Links to related pages
- Current status if useful

### `overview.md`

High-level explanation of the item.

Include:

- Purpose
- Host, container, VM, device, location, or deployment context
- Related services or dependencies
- Important paths
- URLs, ports, or interfaces if relevant
- Quick commands
- Backup/restore summary if relevant
- Any important design decisions

### `configuration.md`

Configuration details that are easy to forget.

Include:

- Config file paths
- Environment files
- Systemd services, timers, or overrides
- Users/groups/permissions
- Storage paths
- Network interfaces
- Ports
- Mounts, volumes, bind mounts, or datasets
- Relevant options/settings
- Firmware settings, device settings, or UI settings if applicable
- Notes about config that should not be overwritten

Do not include secrets. Use placeholders like:

```text
<REDACTED>
<SECRET>
<API_TOKEN>
```

### `updates.md`

How the item is updated, rebuilt, upgraded, patched, or maintained.

Include whichever apply:

- Manual update commands
- Scheduled update behavior
- Package manager details
- Source build procedure
- Git repository information
- Container image update flow
- Firmware update flow
- CI/CD or GitHub Actions behavior
- Relevant systemd services/timers
- Log locations
- Backup behavior before updates
- Rollback notes
- Safety notes
- Commands to disable scheduled updates if applicable

### `scripts.md`

Scripts related to the item.

Include:

- Script name
- Purpose
- Location
- Owner/permissions
- Arguments
- Usage examples
- Logs
- Related services, timers, cron jobs, or automations
- Full script content when useful
- Recovery or rollback notes if the script modifies anything important

When documenting a script, use fenced code blocks and specify the language when possible.

Example:

```bash
/usr/local/sbin/example-script.sh --force
```

### `changes.md`

Reverse-chronological change log for the item.

Every meaningful real-world modification should add or update an entry here.

Use this format:

```markdown
## YYYY-MM-DD â Short change title

### Changed
- What changed.

### Reason
- Why the change was made.

### Files / paths touched
- `/path/to/file`

### Commands used
```bash
example command
```

### Notes
- Follow-up details, caveats, or things to check later.
```

Newest entries go at the top.

### `notes.md`

Loose reference notes.

Use this for:

- Gotchas
- Observations
- Workarounds
- Future ideas
- Links/references
- Weird behavior
- Things to verify later
- Decision notes
- Migration notes
- Vendor-specific quirks
- Anything useful that does not belong elsewhere

Keep notes scannable with headings and short sections.

---

## Item structure guidance

Use the full page set for complex or important items.

Recommended full structure:

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

For smaller items, a single `index.md` may be enough.

Small item example:

```text
docs/hardware/usb-zigbee-radio/index.md
```

For items that are mostly scripts, use:

```text
docs/automation/<automation-name>/
  index.md
  scripts.md
  changes.md
  notes.md
```

For items that are mostly hardware notes, use:

```text
docs/hardware/<device-name>/
  index.md
  overview.md
  configuration.md
  firmware.md
  changes.md
  notes.md
```

Add custom pages when they genuinely improve organization, but avoid creating lots of one-off page names unless needed.

---

## Templates

Reusable templates live under:

```text
docs/templates/
```

Expected templates:

```text
item-template.md
script-template.md
change-log-template.md
notes-template.md
```

Optional templates may be added as needed:

```text
service-template.md
hardware-template.md
networking-template.md
automation-template.md
migration-template.md
backup-restore-template.md
```

When adding a new documented item, start from the relevant template instead of inventing a new format.

Keep templates practical and concise. They should help future updates stay consistent.

---

## Navigation requirements

When adding, removing, or renaming documentation pages, update:

```text
mkdocs.yml
```

The MkDocs navigation should remain logical and hierarchical.

Avoid dumping every page into a flat list.

Preferred navigation style:

```yaml
nav:
  - Home: index.md
  - Infrastructure:
      - infrastructure/index.md
      - Example Infrastructure Item:
          - Overview: infrastructure/example-item/overview.md
          - Configuration: infrastructure/example-item/configuration.md
          - Updates: infrastructure/example-item/updates.md
          - Scripts: infrastructure/example-item/scripts.md
          - Changes: infrastructure/example-item/changes.md
          - Notes: infrastructure/example-item/notes.md
  - Services:
      - services/index.md
      - Example Service:
          - Overview: services/example-service/overview.md
          - Configuration: services/example-service/configuration.md
          - Updates: services/example-service/updates.md
          - Scripts: services/example-service/scripts.md
          - Changes: services/example-service/changes.md
          - Notes: services/example-service/notes.md
```

Keep display names human-friendly.

Use clear folder/file names:

- lowercase
- hyphen-separated
- no spaces
- descriptive but not overly long

Good:

```text
scheduled-updates.md
update-script.md
```

Better, if matching the repo convention:

```text
updates.md
scripts.md
```

Avoid:

```text
stuff.md
misc2.md
new-new-final.md
```

---

## Design and style

This is a personal technical reference. Design should be clean, calm, and practical.

Priorities:

1. Accurate
2. Easy to scan
3. Easy to update
4. Consistent
5. Not overbuilt

Use:

- Clear headings
- Short paragraphs
- Tables for compact reference data
- Code blocks for commands/scripts/config
- Admonitions for important notes
- Cross-links between related items
- Short summaries before long details

Good admonition examples:

```markdown
!!! note
    This service uses generated systemd units from SysV init scripts.

!!! warning
    Do not store secrets in this repository.

!!! tip
    Use `systemctl list-timers --all` to verify scheduled jobs.
```

Avoid:

- Marketing copy
- Overly formal public-facing language
- Decorative complexity
- Huge unstructured walls of text
- Unexplained acronyms when a short note would help later
- Overly broad advice that is not tied to a documented item
- Guessing or filling gaps with made-up details

Tone should be practical, direct, and written for the repository owner.

---

## Code block requirements

Use fenced code blocks for commands, config, scripts, and logs.

Specify language when practical:

````markdown
```bash
systemctl status example.service --no-pager
```

```ini
[Service]
Restart=always
```

```yaml
nav:
  - Home: index.md
```
````

For command examples, prefer copy-pasteable commands.

Avoid including destructive commands unless clearly labeled.

If a command deletes, overwrites, disables, migrates, rebuilds, or restarts something important, add a warning or explanation.

For long scripts, include:

- Script path
- Purpose
- Dependencies
- Arguments
- Usage examples
- Log path
- Full script content, if useful
- Last verified date, if known

---

## Change log maintenance

When modifying documentation for an existing item, update that itemâs `changes.md` when the modification reflects a meaningful real-world change, decision, workaround, script, configuration edit, update process, migration, repair, firmware change, or operational discovery.

Do not update `changes.md` for purely cosmetic documentation edits unless the edit itself matters.

A good change-log entry answers:

- What changed?
- Why did it change?
- What files, paths, services, devices, or settings were affected?
- What commands were used?
- What should be remembered later?
- Was anything restarted, rebuilt, migrated, disabled, or backed up?
- Is follow-up verification needed?

Use the current date if known. If the date is unknown, use:

```text
YYYY-MM-DD
```

or clearly mark it as approximate.

Newest entries go first.

---

## Secrets and sensitive information

Never commit secrets.

Do not add:

- Passwords
- API keys
- Private keys
- Recovery keys
- OAuth secrets
- Database credentials
- Tailscale auth keys
- Cloudflare tokens
- GitHub tokens
- Home Assistant long-lived access tokens
- Wi-Fi passwords
- Real private credentials of any kind

Use placeholders instead:

```text
<REDACTED>
<SECRET>
<API_TOKEN>
<PRIVATE_KEY>
```

If a doc needs to mention where a secret is stored, document the location and purpose only.

Example:

```markdown
The API token is stored in `/etc/example/example.env` as `EXAMPLE_API_TOKEN`.

Do not commit the token value.
```

If credentials, keys, or tokens appear in pasted notes, remove or redact them before committing.

---

## Accuracy requirements

Do not invent details.

If a detail is unknown, mark it clearly:

```markdown
Unknown / not documented yet.
```

or:

```markdown
TODO: verify this path.
```

Prefer incomplete-but-accurate notes over polished guesses.

When converting shell history, chat notes, screenshots, logs, or rough notes into documentation:

- Preserve exact paths
- Preserve exact service names
- Preserve exact timer names
- Preserve exact commands
- Preserve exact script arguments
- Preserve exact config keys
- Preserve exact device names or model numbers when known
- Do not silently âclean upâ commands in a way that changes behavior

If something seems unsafe, stale, version-specific, or ambiguous, add a note instead of pretending it is certain.

When documenting current behavior, include the date verified if useful:

```markdown
Verified: YYYY-MM-DD
```

---

## MkDocs / GitHub Pages workflow

The repo should be deployable to GitHub Pages using the included GitHub Actions workflow.

Do not change the deployment workflow unless requested.

Expected local preview flow:

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
mkdocs serve
```

Expected build command:

```bash
mkdocs build
```

Before finalizing structural changes, ensure:

```bash
mkdocs build
```

succeeds without broken nav paths.

---

## Agent workflow for updates

When asked to update this repository:

1. Identify the correct category:
   - infrastructure
   - services
   - applications
   - networking
   - hardware
   - automation
   - scripts
   - templates

2. Identify or create the correct item folder.

3. Use the existing page convention when appropriate:
   - `index.md`
   - `overview.md`
   - `configuration.md`
   - `updates.md`
   - `scripts.md`
   - `changes.md`
   - `notes.md`

4. Add information to the most appropriate page.

5. Create a new page only when it improves organization.

6. Update `changes.md` if the information represents a meaningful real-world change.

7. Update `mkdocs.yml` navigation if files or sections were added, removed, or renamed.

8. Keep wording concise and scannable.

9. Do not add secrets.

10. Mark unknowns clearly instead of guessing.

11. Run or recommend `mkdocs build` after structural changes.

12. Summarize what changed.

---

## Adding a new documented item

When adding a new service, application, device, automation, or infrastructure component:

1. Choose the best category.
2. Create a folder using a lowercase hyphenated name.
3. Start from the closest template in `docs/templates/`.
4. Add the item to `mkdocs.yml`.
5. Add a useful `index.md`.
6. Add additional pages only as needed.
7. Include exact paths, service names, commands, ports, and settings where known.
8. Add a `changes.md` entry if the item was newly created, migrated, rebuilt, automated, or significantly changed.
9. Avoid storing secrets.

Example:

```text
docs/services/example-service/
  index.md
  overview.md
  configuration.md
  updates.md
  scripts.md
  changes.md
  notes.md
```

---

## Documenting scripts and automation

Scripts and automation should be documented clearly enough that they can be understood months later.

Include:

- What the script/job does
- Why it exists
- Where it lives
- What user runs it
- What arguments it accepts
- Whether it is safe to run manually
- Whether it is scheduled
- How it is scheduled
- What logs it writes
- What files/services it touches
- How to disable it
- How to force it, if applicable
- What to verify afterward

For scheduled jobs, document the scheduler type:

- systemd timer
- cron
- GitHub Actions
- Home Assistant automation
- external scheduler
- application-native scheduler

For systemd timers, include commands like:

```bash
systemctl list-timers --all | grep -i <name>
systemctl status <name>.timer --no-pager
systemctl status <name>.service --no-pager
journalctl -u <name>.service -n 120 --no-pager
```

For cron jobs, include the relevant crontab or cron file path.

---

## Documenting updates and rebuilds

For any update process, capture:

- Whether updates are manual, scheduled, or automatic
- Whether updates are package-based, source-built, container-based, firmware-based, or UI-driven
- Whether updates interrupt service
- Whether backups are taken before updates
- What log file or journal unit records the update
- How to force an update/rebuild if safe
- How to disable automatic updates
- How to verify success afterward
- Any rollback notes

Avoid unattended forced rebuilds unless explicitly intended and documented.

---

## Documenting configuration

Configuration pages should capture the exact details that are painful to rediscover later.

Include:

- Paths
- Services
- Timers
- Ports
- URLs
- Interface names
- Dataset/volume names
- Mount points
- Environment files
- Override files
- User/group ownership
- Permissions
- UI settings
- Firmware versions
- Device model numbers
- Notes about what should not be overwritten

If the value is sensitive, document the key name and location, not the secret value.

---

## Cross-linking

When two documented items relate to each other, add links between them.

Examples:

- A service depends on a database.
- A script updates a service.
- A hardware device is used by an infrastructure service.
- A networking rule affects an application.
- A backup job protects a dataset.

Prefer relative Markdown links where practical.

Example:

```markdown
Related: [Example Service](../../services/example-service/index.md)
```

---

## Preferred documentation habits

When adding technical notes, include the actual command or path whenever possible.

Bad:

```markdown
Restart the service.
```

Good:

````markdown
Restart the service:

```bash
systemctl restart example.service
```
````

Bad:

```markdown
Logs are in the normal place.
```

Good:

````markdown
Logs:

```bash
journalctl -u example.service -n 120 --no-pager
tail -n 120 /var/log/example.log
```
````

Bad:

```markdown
Config is in the default file.
```

Good:

```markdown
Primary config:

```text
/etc/example/example.conf
```
```

---

## Maintenance philosophy

This repository should reduce future confusion.

When in doubt, document:

- The exact path
- The exact service name
- The exact command
- The exact file touched
- The exact setting changed
- The reason for the change
- The date
- Any caveats
- What to verify afterward

Keep it boring, clear, and useful.