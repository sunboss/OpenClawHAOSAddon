# Changelog

This project is now treated as a fresh baseline.
Historical update records were intentionally removed.

## [2026.04.01.3] - 2026-04-01

## [2026.04.01.4] - 2026-04-01

### Changed
- Translate the HAOS landing page to Chinese and add terminal quick-command buttons for common OpenClaw diagnostics and setup flows.

### Fixed
- Fix local ingress health responses so the landing page reads the official `openclaw health --json` payload instead of a wrapped action-server envelope.
- Fix landing-page ingress URL resolution under Home Assistant so health, token, and action requests resolve against the add-on ingress base path.
- Make the native Gateway UI button fetch the gateway token first and open the Control UI with `#token=...` when available.

### Changed
- Adopt `Asia/Shanghai`, `access_mode: lan_https`, `enable_openai_api: true`, and `auto_configure_mcp: true` as the project defaults for the HAOS add-on profile.
- Keep `gateway_trusted_proxies` and `gateway_additional_allowed_origins` empty by default instead of shipping unsafe wildcard values.

### Fixed
- Update the documentation default-value tables so they match the shipped add-on configuration again.

## [2026.04.01.2] - 2026-04-01

### Fixed
- Fix local landing-page version rendering so the add-on version is read from the shipped add-on config instead of a missing labels file.
- Fix local ingress health checks to probe the running OpenClaw gateway via the local action server instead of a broken direct `/health` assumption.
- Fix first-boot onboarding flags for OpenClaw `2026.3.31` by removing the unsupported `--no-open` option.
- Improve landing-page readability with a light high-contrast theme for HAOS.
- Normalize the displayed OpenClaw version so the UI shows a clean semantic version instead of the raw CLI banner string.

## [2026.04.01.1] - 2026-04-01

### Changed
- Rename the add-on branding to `OpenClaw HAOS Add-on` and align repository/image references with the new project identity.
- Bump bundled OpenClaw runtime from `2026.3.28` to `2026.3.31`.
- Align add-on behavior more closely with current upstream gateway/auth expectations for secure contexts, remote mode, and trusted-proxy access.
- Replace corrupted ingress renderer and landing page assets with clean UTF-8 versions.

### Fixed
- Fix startup-breaking issues in `render_nginx.py`, `oc_config_helper.py`, and `landing.html.tpl`.
- Fix `run.sh` helper ordering, certificate failure handling, ingress health/token endpoints, and stricter `lan_reverse_proxy` validation.
- Fix stale docs and metadata that no longer matched shipped behavior.

## [2026.03.31.3] - 2026-03-31

### Changed
- **landing.html.tpl**: 全新落地页 UI，暗色卡片风格，包含服务状态、版本信息、操作按钮、快速诊断、折叠帮助、嵌入终端。
- **landing.html.tpl**: 新增磁盘/内存/CPU 进度条，运行状态实时检测（每30秒刷新）。
- **landing.html.tpl**: Token 默认隐藏，点击"显示"后可一键复制；Gateway 地址可复制。
- **landing.html.tpl**: 新增"检测更新"按钮，自动对比 npm 最新版本。
- **landing.html.tpl**: 新增"重启服务"/"停止服务"按钮（带确认对话框）。
- **landing.html.tpl**: 诊断区显示 Gateway/访问模式/HTTPS/IPv4/Chromium/MCP 六项状态。
- **render_nginx.py**: 新增注入变量：`MEM_*`、`CPU_PCT`、`OPENCLAW_VERSION`、`NODE_VERSION`、`ADDON_VERSION`、`MCP_STATUS`、`TERMINAL_PORT`。
- **run.sh**: 启动时收集内存（从 `/proc/meminfo`）和 CPU（从 `/proc/loadavg`）数据并传给渲染脚本。



### Changed
- **Dockerfile**: Upgrade base image from `debian:bookworm-slim` + NodeSource Node 22 to official `node:24-bookworm-slim`. Aligns with upstream recommended runtime (Node 24), removes manual NodeSource setup, and directly fixes IPv6/fetch timeout issues reported in HAOS VMs.
- **Dockerfile**: `OPENCLAW_VERSION` is now an ARG, enabling reproducible builds and automated version bumps via Dependabot.
- **Dockerfile**: Chromium is now installed via Playwright (managed by openclaw) instead of `apt-get`, ensuring CDP version compatibility with the openclaw browser tool.
- **run.sh**: First-boot now runs `openclaw onboard --no-install-daemon --mode local --no-open` to properly initialise workspace and skill paths in container mode (no systemd/launchd daemon).
- **run.sh**: Added `sandbox_mode` option — writes `agents.defaults.sandbox.mode` into `openclaw.json`. Defaults to `off`; set to `non-main` for multi-user group isolation.
- **run.sh**: Gateway startup now triggers `openclaw doctor` asynchronously (15 s after launch) to surface misconfigurations in add-on logs.

### Added
- **config.yaml / run.sh**: Dedicated fields for common channel tokens (`telegram_bot_token`, `discord_bot_token`, `slack_bot_token`, `slack_app_token`). Values are auto-injected into `openclaw.json` on startup — no manual JSON editing needed.
- **config.yaml**: `sandbox_mode` option (`off` / `non-main`).
- **.github/dependabot.yml**: Daily Dependabot tracking for `openclaw` npm package. Auto-opens PRs when upstream publishes a new version.
- **.github/workflows/sync-openclaw-version.yml**: Workflow that auto-updates `OPENCLAW_VERSION` in `Dockerfile` when Dependabot bumps `package.json`.
- **openclaw_assistant/package.json**: Dependency manifest used by Dependabot to track `openclaw` npm releases.

## [2026.03.31.1] - 2026-03-31

### Added
- Fresh baseline initialization.
- Security/authentication behavior aligned to current project policy.
- Versioning scheme switched to `YYYY.MM.DD.N` (date + daily sequence).

### Changed
- Bump bundled OpenClaw runtime from `2026.3.13` to `2026.3.28` (official latest at update time).
