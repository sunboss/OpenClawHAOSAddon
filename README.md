# OpenClaw HAOS Add-on

This repository contains the maintained Home Assistant OS add-on project under `sunboss`.
It runs OpenClaw inside HAOS with an ingress control page, embedded terminal, and persistent workspace/config storage.

## Repository

- Add-on repository URL:
  - `https://github.com/sunboss/OpenClawHAOSAddon`

## Highlights

- OpenClaw gateway runtime in Home Assistant OS
- HAOS control page with system metrics and native Gateway UI handoff
- Embedded terminal for onboarding and maintenance
- Persistent storage for config, skills, and workspace
- Chromium, Node.js, Homebrew, and CLI tooling bundled
- Prebuilt GHCR image delivery (no local HAOS image build required)

## Versioning

- The Home Assistant add-on version uses `YYYY.MM.DD.N`.
- Example: the first release on April 1, 2026 is `2026.04.01.1`.
- The bundled OpenClaw runtime version is tracked separately and does not replace the add-on version.

## Supported Architectures

- `amd64`
- `aarch64`

## Documentation

- [DOCS.md](DOCS.md): installation, configuration, usage, troubleshooting
- [SECURITY.md](SECURITY.md): security risks and operational cautions
- [AUTHENTICATION_SECURITY_ZH_EN.md](AUTHENTICATION_SECURITY_ZH_EN.md): authentication/security baseline notes

## Install

1. Home Assistant -> `Settings -> Add-ons -> Add-on store`
2. Top-right menu -> `Repositories`
3. Add:
   - `https://github.com/sunboss/OpenClawHAOSAddon`
4. Install `OpenClaw HAOS Add-on`

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=sunboss/OpenClawHAOSAddon&type=date&legend=top-left)](https://www.star-history.com/#sunboss/OpenClawHAOSAddon&type=date&legend=top-left)
