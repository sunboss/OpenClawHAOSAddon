#!/usr/bin/env python3
"""
Render nginx.conf and landing page HTML from templates.
"""

from __future__ import annotations

import html
import json
import os
import subprocess
from pathlib import Path


def env(name: str, default: str = "") -> str:
    return os.environ.get(name, default)


def js_string(value: str) -> str:
    return json.dumps(value)


def main() -> None:
    tpl = Path("/etc/nginx/nginx.conf.tpl").read_text(encoding="utf-8")
    landing_tpl = Path("/etc/nginx/landing.html.tpl").read_text(encoding="utf-8")

    public_url = env("GW_PUBLIC_URL", "")
    terminal_port = env("TERMINAL_PORT", "7681")
    gateway_port = env("GATEWAY_PORT", "18789")
    enable_https = env("ENABLE_HTTPS_PROXY", "false") == "true"
    https_port = env("HTTPS_PROXY_PORT", "")
    internal_gw_port = env("GATEWAY_INTERNAL_PORT", "")
    access_mode = env("ACCESS_MODE", "custom")
    gateway_mode = env("GATEWAY_MODE", "local")
    nginx_log_level = env("NGINX_LOG_LEVEL", "minimal")

    disk_total = env("DISK_TOTAL", "-")
    disk_used = env("DISK_USED", "-")
    disk_avail = env("DISK_AVAIL", "-")
    disk_pct = env("DISK_PCT", "")
    mem_total = env("MEM_TOTAL", "-")
    mem_used = env("MEM_USED", "-")
    mem_pct = env("MEM_PCT", "-")
    cpu_pct = env("CPU_PCT", "0")
    openclaw_version = env("OPENCLAW_VERSION", "-")
    node_version = env("NODE_VERSION", "-")
    addon_version = env("ADDON_VERSION", "-")
    mcp_status = env("MCP_STATUS", "")
    memory_search_enabled = env("MEMORY_SEARCH_ENABLED", "false")
    memory_search_provider = env("MEMORY_SEARCH_PROVIDER", "")
    memory_search_model = env("MEMORY_SEARCH_MODEL", "")
    token_available = env("GATEWAY_TOKEN_AVAILABLE", "false")
    gw_pid = env("GW_PID", "-")
    nginx_pid = env("NGINX_PID", "-")
    ttyd_pid = env("TTYD_PID", "-")
    action_pid = env("ACTION_PID", "-")

    gw_path = "" if public_url.endswith("/") else "/"

    if nginx_log_level == "minimal":
        access_log_block = (
            "# Suppress repetitive HA health-check / polling requests\n"
            "  map $http_user_agent $loggable {\n"
            "    ~HomeAssistant 0;\n"
            "    default 1;\n"
            "  }\n"
            "  access_log /dev/stdout combined if=$loggable;"
        )
    else:
        access_log_block = "access_log /dev/stdout;"

    conf = tpl.replace("__NGINX_ACCESS_LOG__", access_log_block)
    conf = conf.replace("__TERMINAL_PORT__", terminal_port)

    https_block = ""
    if enable_https and https_port and internal_gw_port:
        https_block = f"""
    # --- HTTPS Gateway Proxy (lan_https mode) ---
    server {{
        listen {https_port} ssl;

        ssl_certificate     /config/certs/gateway.crt;
        ssl_certificate_key /config/certs/gateway.key;
        ssl_protocols       TLSv1.2 TLSv1.3;
        ssl_ciphers         HIGH:!aNULL:!MD5;

        location / {{
            proxy_pass http://127.0.0.1:{internal_gw_port};
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto https;
            proxy_read_timeout 86400s;
            proxy_send_timeout 86400s;
            proxy_buffering off;
        }}

        location = /cert/ca.crt {{
            alias /etc/nginx/html/openclaw-ca.crt;
            default_type application/x-x509-ca-cert;
            add_header Content-Disposition 'attachment; filename="openclaw-ca.crt"';
        }}
    }}
"""

    conf = conf.replace("__HTTPS_GATEWAY_BLOCK__", https_block)
    Path("/etc/nginx/nginx.conf").write_text(conf, encoding="utf-8")

    if enable_https and not public_url:
        try:
            lan_ip = subprocess.check_output(["hostname", "-I"], text=True, timeout=2).split()[0]
        except Exception:
            lan_ip = "127.0.0.1"
        public_url = f"https://{lan_ip}:{https_port}"
        gw_path = "/"

    replacements = {
        "__ACCESS_MODE__": html.escape(access_mode),
        "__GATEWAY_MODE__": html.escape(gateway_mode),
        "__GATEWAY_PUBLIC_URL__": html.escape(public_url),
        "__GW_PUBLIC_URL_PATH__": html.escape(gw_path),
        "__DISK_TOTAL__": html.escape(disk_total),
        "__DISK_USED__": html.escape(disk_used),
        "__DISK_AVAIL__": html.escape(disk_avail),
        "__DISK_PCT__": html.escape(disk_pct),
        "__MEM_TOTAL__": html.escape(mem_total),
        "__MEM_USED__": html.escape(mem_used),
        "__MEM_PCT__": html.escape(mem_pct),
        "__CPU_PCT__": html.escape(cpu_pct),
        "__OPENCLAW_VERSION__": html.escape(openclaw_version),
        "__NODE_VERSION__": html.escape(node_version),
        "__ADDON_VERSION__": html.escape(addon_version),
        "__MCP_STATUS__": html.escape(mcp_status),
        "__MEMORY_SEARCH_ENABLED__": html.escape(memory_search_enabled),
        "__MEMORY_SEARCH_PROVIDER__": html.escape(memory_search_provider),
        "__MEMORY_SEARCH_MODEL__": html.escape(memory_search_model),
        "__GW_PID__": html.escape(gw_pid),
        "__NGINX_PID__": html.escape(nginx_pid),
        "__TTYD_PID__": html.escape(ttyd_pid),
        "__ACTION_PID__": html.escape(action_pid),
        "__TERMINAL_PORT__": html.escape(terminal_port),
        "__GATEWAY_PORT__": html.escape(gateway_port),
        "__HTTPS_PORT__": html.escape(https_port if enable_https else ""),
        "__TOKEN_AVAILABLE__": html.escape(token_available),
        "__GW_URL_JSON__": js_string(public_url),
        "__ACCESS_MODE_JSON__": js_string(access_mode),
        "__GATEWAY_MODE_JSON__": js_string(gateway_mode),
        "__DISK_PCT_JSON__": js_string(disk_pct),
        "__DISK_AVAIL_JSON__": js_string(disk_avail),
        "__MEM_PCT_JSON__": js_string(mem_pct),
        "__CPU_PCT_JSON__": js_string(cpu_pct),
        "__HTTPS_PORT_JSON__": js_string(https_port if enable_https else ""),
        "__TOKEN_AVAILABLE_JSON__": js_string(token_available),
        "__OPENCLAW_VERSION_JSON__": js_string(openclaw_version),
        "__MEMORY_SEARCH_ENABLED_JSON__": js_string(memory_search_enabled),
        "__MEMORY_SEARCH_PROVIDER_JSON__": js_string(memory_search_provider),
        "__MEMORY_SEARCH_MODEL_JSON__": js_string(memory_search_model),
    }

    landing = landing_tpl
    for key, value in replacements.items():
        landing = landing.replace(key, value)

    out_dir = Path("/etc/nginx/html")
    out_dir.mkdir(parents=True, exist_ok=True)
    out_file = out_dir / "index.html"
    out_file.write_text(landing, encoding="utf-8")

    try:
        out_dir.chmod(0o755)
        out_file.chmod(0o644)
    except Exception:
        pass


if __name__ == "__main__":
    main()
