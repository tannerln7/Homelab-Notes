# Personal Documentation

This site is the working notebook for infrastructure, services, applications, networking, hardware, automation, and scripts. It is meant for later recovery, not polished public-facing documentation.

## What to record

- Exact paths, service names, timers, ports, commands, and file locations.
- Update, backup, rebuild, and rollback procedures.
- Weird behavior, workarounds, and things that are easy to forget.
- Real-world changes that should also land in an item's `changes.md`.

## Section map

- [Infrastructure](infrastructure/index.md) for hosts, LXCs, VMs, core platforms, and foundational components.
- [Services](services/index.md) for long-running apps and server-side services.
- [Applications](applications/index.md) for user-facing or integration-heavy applications.
- [Networking](networking/index.md) for VLANs, DNS, DHCP, firewall rules, Wi-Fi, and routing notes.
- [Hardware](hardware/index.md) for physical devices, firmware, and repairs.
- [Automation](automation/index.md) for timers, jobs, recurring workflows, and update automation.
- [Scripts](scripts/index.md) for reusable scripts that are worth indexing directly.
- [Templates](templates/item-template.md) for reusable documentation starters.

!!! warning
    Do not store secrets in this repository. Record locations and key names only.