#!/usr/bin/env python3
"""
OpenClaw config helper for the Home Assistant add-on.
"""

from __future__ import annotations

import json
import os
import sys
from pathlib import Path

CONFIG_PATH = Path(os.environ.get("OPENCLAW_CONFIG_PATH", "/config/.openclaw/openclaw.json"))


def read_config():
    if not CONFIG_PATH.exists():
        return None
    try:
        return json.loads(CONFIG_PATH.read_text(encoding="utf-8"))
    except (json.JSONDecodeError, OSError) as exc:
        print(f"ERROR: Failed to read config: {exc}", file=sys.stderr)
        return None


def write_config(cfg) -> bool:
    try:
        CONFIG_PATH.parent.mkdir(parents=True, exist_ok=True)
        CONFIG_PATH.write_text(json.dumps(cfg, indent=2) + "\n", encoding="utf-8")
        return True
    except OSError as exc:
        print(f"ERROR: Failed to write config: {exc}", file=sys.stderr)
        return False


def get_gateway_setting(key, default=None):
    cfg = read_config()
    if cfg is None:
        return default
    return cfg.get("gateway", {}).get(key, default)


def set_gateway_setting(key, value) -> bool:
    cfg = read_config() or {}
    cfg.setdefault("gateway", {})[key] = value
    return write_config(cfg)


def set_json_path(path: str, value) -> bool:
    if not path:
        print("ERROR: Empty json path")
        return False

    cfg = read_config() or {}
    current = cfg
    parts = [part for part in path.split(".") if part]
    if not parts:
        print("ERROR: Invalid json path")
        return False

    for part in parts[:-1]:
        next_value = current.get(part)
        if not isinstance(next_value, dict):
            next_value = {}
            current[part] = next_value
        current = next_value

    current[parts[-1]] = value
    if write_config(cfg):
        print(f"INFO: Updated {path}")
        return True
    return False


def apply_gateway_settings(
    mode: str,
    remote_url: str,
    bind_mode: str,
    port: int,
    enable_openai_api: bool,
    auth_mode: str,
    trusted_proxies_csv: str,
) -> bool:
    if mode not in ["local", "remote"]:
        print(f"ERROR: Invalid mode '{mode}'. Must be 'local' or 'remote'")
        return False

    if bind_mode not in ["loopback", "lan", "tailnet"]:
        print(f"ERROR: Invalid bind_mode '{bind_mode}'. Must be 'loopback', 'lan', or 'tailnet'")
        return False

    if port < 1 or port > 65535:
        print(f"ERROR: Invalid port {port}. Must be between 1 and 65535")
        return False

    if auth_mode not in ["token", "trusted-proxy"]:
        print(f"ERROR: Invalid auth_mode '{auth_mode}'. Must be 'token' or 'trusted-proxy'")
        return False

    cfg = read_config() or {}
    gateway = cfg.setdefault("gateway", {})
    remote_cfg = gateway.setdefault("remote", {})
    auth = gateway.setdefault("auth", {})
    chat_completions = gateway.setdefault("http", {}).setdefault("endpoints", {}).setdefault(
        "chatCompletions", {}
    )

    trusted_proxies = [item.strip() for item in trusted_proxies_csv.split(",") if item.strip()]
    trusted_proxy_cfg_default = {"userHeader": "x-forwarded-user"}
    changes = []

    if gateway.get("mode") != mode:
        changes.append(f"mode: {gateway.get('mode', '')} -> {mode}")
        gateway["mode"] = mode

    if remote_cfg.get("url", "") != remote_url:
        changes.append(f"remote.url: {remote_cfg.get('url', '')} -> {remote_url}")
        remote_cfg["url"] = remote_url

    if gateway.get("bind") != bind_mode:
        changes.append(f"bind: {gateway.get('bind', '')} -> {bind_mode}")
        gateway["bind"] = bind_mode

    if gateway.get("port", 18789) != port:
        changes.append(f"port: {gateway.get('port', 18789)} -> {port}")
        gateway["port"] = port

    if chat_completions.get("enabled", False) != enable_openai_api:
        changes.append(
            f"chatCompletions.enabled: {chat_completions.get('enabled', False)} -> {enable_openai_api}"
        )
        chat_completions["enabled"] = enable_openai_api

    if auth.get("mode", "token") != auth_mode:
        changes.append(f"auth.mode: {auth.get('mode', 'token')} -> {auth_mode}")
        auth["mode"] = auth_mode

    if gateway.get("trustedProxies", []) != trusted_proxies:
        changes.append(f"trustedProxies: {gateway.get('trustedProxies', [])} -> {trusted_proxies}")
        gateway["trustedProxies"] = trusted_proxies

    if auth_mode == "trusted-proxy":
        if auth.get("trustedProxy") != trusted_proxy_cfg_default:
            auth["trustedProxy"] = trusted_proxy_cfg_default
            changes.append("auth.trustedProxy: configured default userHeader=x-forwarded-user")
    elif "trustedProxy" in auth:
        del auth["trustedProxy"]
        changes.append("auth.trustedProxy: removed")

    if not changes:
        print(
            "INFO: Gateway settings already correct "
            f"(mode={mode}, remoteUrl={remote_url}, bind={bind_mode}, port={port}, "
            f"chatCompletions={enable_openai_api}, authMode={auth_mode}, trustedProxies={trusted_proxies})"
        )
        return True

    if write_config(cfg):
        print(f"INFO: Updated gateway settings: {', '.join(changes)}")
        return True

    print("ERROR: Failed to write config")
    return False


def set_control_ui_origins(origins_csv: str, additional_origins_csv: str = "") -> bool:
    cfg = read_config() or {}
    gateway = cfg.setdefault("gateway", {})
    control_ui = gateway.setdefault("controlUi", {})

    default_origins = [item.strip() for item in origins_csv.split(",") if item.strip()]
    additional_origins = [item.strip() for item in additional_origins_csv.split(",") if item.strip()]
    current_origins = control_ui.get("allowedOrigins", [])
    if not isinstance(current_origins, list):
        current_origins = []

    merged_origins = []
    for origin in [*default_origins, *current_origins, *additional_origins]:
        if isinstance(origin, str) and origin and origin not in merged_origins:
            merged_origins.append(origin)

    changes = []
    desired_device_auth_flag = False
    desired_allow_insecure_auth = False

    if current_origins != merged_origins:
        control_ui["allowedOrigins"] = merged_origins
        changes.append(f"allowedOrigins: {current_origins} -> {merged_origins}")

    if control_ui.get("dangerouslyDisableDeviceAuth") is not desired_device_auth_flag:
        prev = control_ui.get("dangerouslyDisableDeviceAuth")
        control_ui["dangerouslyDisableDeviceAuth"] = desired_device_auth_flag
        changes.append(f"dangerouslyDisableDeviceAuth: {prev} -> {desired_device_auth_flag}")

    if control_ui.get("allowInsecureAuth") is not desired_allow_insecure_auth:
        prev = control_ui.get("allowInsecureAuth")
        control_ui["allowInsecureAuth"] = desired_allow_insecure_auth
        changes.append(f"allowInsecureAuth: {prev} -> {desired_allow_insecure_auth}")

    for stale_key in ("pairingMode",):
        if stale_key in control_ui:
            del control_ui[stale_key]
            changes.append(f"removed invalid key: {stale_key}")

    if not changes:
        print(
            "INFO: controlUi already correct: "
            f"origins={merged_origins}, deviceAuth=enabled, allowInsecureAuth=disabled"
        )
        return True

    if write_config(cfg):
        print(f"INFO: Updated controlUi: {', '.join(changes)}")
        return True

    print("ERROR: Failed to write config")
    return False


def main():
    if len(sys.argv) < 2:
        print("Usage: oc_config_helper.py <command> [args...]")
        sys.exit(1)

    cmd = sys.argv[1]

    if cmd == "apply-gateway-settings":
        if len(sys.argv) != 9:
            print(
                "Usage: oc_config_helper.py apply-gateway-settings "
                "<local|remote> <remote_url> <loopback|lan|tailnet> <port> "
                "<enable_openai_api:true|false> <auth_mode:token|trusted-proxy> "
                "<trusted_proxies_csv>"
            )
            sys.exit(1)
        ok = apply_gateway_settings(
            sys.argv[2],
            sys.argv[3],
            sys.argv[4],
            int(sys.argv[5]),
            sys.argv[6].lower() == "true",
            sys.argv[7],
            sys.argv[8],
        )
        sys.exit(0 if ok else 1)

    if cmd == "get":
        if len(sys.argv) != 3:
            print("Usage: oc_config_helper.py get <key>")
            sys.exit(1)
        value = get_gateway_setting(sys.argv[2])
        if value is not None:
            print(value)
        sys.exit(0)

    if cmd == "set-control-ui-origins":
        if len(sys.argv) not in (3, 4):
            print("Usage: oc_config_helper.py set-control-ui-origins <origins_csv> [additional_origins_csv]")
            sys.exit(1)
        ok = set_control_ui_origins(sys.argv[2], sys.argv[3] if len(sys.argv) == 4 else "")
        sys.exit(0 if ok else 1)

    if cmd == "set":
        if len(sys.argv) != 4:
            print("Usage: oc_config_helper.py set <key> <value>")
            sys.exit(1)
        value = sys.argv[3]
        try:
            value = int(value)
        except ValueError:
            pass
        ok = set_gateway_setting(sys.argv[2], value)
        sys.exit(0 if ok else 1)

    if cmd == "set-json-path":
        if len(sys.argv) != 4:
            print("Usage: oc_config_helper.py set-json-path <path> <value>")
            sys.exit(1)
        ok = set_json_path(sys.argv[2], sys.argv[3])
        sys.exit(0 if ok else 1)

    print(f"Unknown command: {cmd}")
    sys.exit(1)


if __name__ == "__main__":
    main()
