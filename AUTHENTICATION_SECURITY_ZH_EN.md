# Authentication & Security Notes (EN / 中文)

## Scope / 范围
- EN: This document describes the authentication and security baseline used by this repository.
- 中文：本文档说明本仓库采用的认证与安全基线。

## Project baseline / 项目基线
- EN: This add-on enforces secure Control UI behavior for fresh installs.
- 中文：本插件在新安装场景下强制执行安全的 Control UI 行为。

- EN: `dangerouslyDisableDeviceAuth` is forced to `false`.
- 中文：`dangerouslyDisableDeviceAuth` 被强制为 `false`。

- EN: `allowInsecureAuth` is forced to `false`.
- 中文：`allowInsecureAuth` 被强制为 `false`。

- EN: URL token query style is not used in active flows.
- 中文：当前流程不使用 URL 查询参数传递 token。

## Why / 原因
- EN: Device-auth bypass and insecure-context auth are downgrade paths and increase operational risk.
- 中文：关闭设备认证或允许不安全上下文认证都属于降级路径，会提高运行风险。

- EN: Putting tokens in URLs can leak credentials to browser history, logs, and referrers.
- 中文：把 token 放在 URL 中会泄漏到浏览器历史、日志和来源引用中。

## References / 参考
- OpenClaw Control UI: https://docs.openclaw.ai/web/control-ui
- OpenClaw Gateway Security: https://docs.openclaw.ai/gateway/security
