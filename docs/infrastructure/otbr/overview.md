# OTBR Overview

## Purpose

This item covers the OpenThread Border Router deployment that runs in a Debian LXC and is maintained from a local source clone.

## Deployment context

- Runtime location: Debian LXC.
- Source tree: `/root/ot-br-posix`.
- Source updates are handled through a dedicated script and systemd timer workflow.

## Known services

- `otbr-agent.service`
- `otbr-web.service`
- `otbr-firewall.service`
- `otbr-nat44.service`
- `otbr-source-update.service`
- `otbr-source-update.timer`

## Operational notes

- Some OTBR services may appear as generated systemd units from SysV init scripts.
- Avoid unattended forced rebuilds.
- Verify `ot-ctl` state after major updates.
- Keep RCP firmware changes documented separately.