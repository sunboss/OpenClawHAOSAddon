# Changelog

This project is now treated as a fresh baseline.
Historical update records were intentionally removed.

## [2026.04.01.12] - 2026-04-01

### Changed
- Add landing-page backup shortcuts for viewing `/share/openclaw-backup/latest` and manually copying `.openclaw` / `.mcporter` into the shared backup folder from the embedded terminal.

## [2026.04.01.11] - 2026-04-01

### Fixed
- Remove the duplicate PID display row from the HAOS landing page and keep a single normalized process row for Gateway, nginx, ttyd, and Action service PIDs.

## [2026.04.01.10] - 2026-04-01

### Fixed
- Add a share-based backup path under `/share/openclaw-backup/latest` for `.openclaw` and `.mcporter`, so state is copied out of the add-on config area without turning the shared folder into a second live runtime.
- Keep the shared copy backup-only: startup no longer restores from `share`, and the add-on continues to use `/config/.openclaw` and `/config/.mcporter` as the sole live state directories.

## [2026.04.01.9] - 2026-04-01

### Changed
- Add dedicated add-on configuration options for Brave Search so Home Assistant users can switch `web_search` from DuckDuckGo to the official Brave provider without hand-editing gateway config.

### Fixed
- Wire the new Brave Search options into startup so enabling the switch exports `BRAVE_API_KEY` and sets `tools.web.search.provider` to `brave` while leaving the main chat model untouched.
- Unify landing-page diagnostics for MCP, web search, and memory search so each capability only appears when enabled and shows its current active provider/model instead of hard-coded assumptions.
- Make Brave Search and Gemini memory-search startup wiring upgrade-safe by treating the add-on toggles as first-time initializers only, so later `openclaw onboard` or manual config changes are preserved across restarts and upgrades.

## [2026.04.01.8] - 2026-04-01

### Changed
- Add dedicated add-on configuration options for Gemini-backed memory search so Home Assistant users can enable semantic memory without hand-editing `gateway_env_vars`.
- Expose a default Gemini embedding model value (`gemini-embedding-001`) directly in the HA add-on configuration UI.

### Fixed
- Wire the new Gemini memory-search options into startup so enabling the switch exports `GEMINI_API_KEY`, configures `agents.defaults.memorySearch` for Gemini, and disables memory search cleanly when the switch is off.

## [2026.04.01.7] - 2026-04-01

### Changed
- Bundle `mcporter` inside the add-on image so Home Assistant MCP can work as a native, always-available runtime instead of showing a missing-tool placeholder.
- Persist MCPorter state under `/config/.mcporter` so Home Assistant MCP registrations survive add-on rebuilds and restarts.
- Add terminal shortcut buttons for `mcporter list HA` and viewing the active MCP config directly from the HAOS landing page.
- Rename the MCP startup toggle to `Enable Native Home Assistant MCP` to reflect that it targets Home Assistant's built-in `/api/mcp` endpoint.

### Fixed
- Rework startup MCP registration to use the persistent MCPorter config under `/config`, verify the registered `HA` server after writing it, and log a clearer failure path when Home Assistant's MCP endpoint is unavailable.

## [2026.04.01.6] - 2026-04-01

### Changed
- Switch first-boot onboarding to the official `openclaw onboard --non-interactive` flow with explicit local-gateway defaults, so fresh installs stop printing the interactive QuickStart wizard during add-on startup.
- Improve MCP diagnostics so the landing page distinguishes between disabled MCP, missing Home Assistant token, and missing `mcporter` tooling.
- Move the Home Assistant MCP startup toggle next to the Home Assistant token field in the add-on configuration UI and rename it to a clearer `Enable Home Assistant MCP`.
- Show live process PID badges for the OpenClaw gateway, nginx, ttyd, and local action server in the HAOS landing page.
- Add an `Auto-Approve Device Pairing` startup toggle for personal HAOS installs so pending local Control UI pairing requests can be approved automatically in the background.

### Fixed
- Auto-trust the built-in loopback HTTPS proxy in `lan_https` mode by adding `127.0.0.1/32` and `::1/128` to `gateway.trustedProxies`, which removes the remaining proxy-header warning from `openclaw security audit`.
- Pre-create `/config/.openclaw/agents/main/sessions` and related agent directories so first-boot doctor checks no longer complain that the session store is missing before the gateway finishes initializing.
- Replace the misleading `run 'openclaw onboard' first` MCP log with a direct message that the current image does not bundle `mcporter`.

## [2026.04.01.5] - 2026-04-01

### Changed
- Refine the HAOS landing page with clearer action-result panels, grouped terminal shortcuts, a native-Gateway cache-clearing tip, and improved copy interactions for gateway URL/token values.

### Fixed
- Improve copy behavior under Home Assistant ingress by falling back to text selection when clipboard APIs are unavailable.
- Clarify the secure-context diagnostic so `lan_https` correctly distinguishes between the HA ingress page and the external native HTTPS Gateway UI.
- Tighten startup permissions for `/config/.openclaw` and `openclaw.json`, and pre-create the persistent workspace memory directory so fresh installs stop raising avoidable `security audit` and `memory status` warnings.

## [2026.04.01.4] - 2026-04-01

### Changed
- Translate the HAOS landing page to Chinese and add terminal quick-command buttons for common OpenClaw diagnostics and setup flows.

### Fixed
- Fix local ingress health responses so the landing page reads the official `openclaw health --json` payload instead of a wrapped action-server envelope.
- Fix landing-page ingress URL resolution under Home Assistant so health, token, and action requests resolve against the add-on ingress base path.
- Make the native Gateway UI button fetch the gateway token first and open the Control UI with `#token=...` when available.

## [2026.04.01.3] - 2026-04-01

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
