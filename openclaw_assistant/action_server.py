#!/usr/bin/env python3
"""
Minimal local action server for HA ingress controls.
Only exposes whitelisted OpenClaw gateway commands.
"""

from __future__ import annotations

import json
import os
import subprocess
from http import HTTPStatus
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

HOST = os.environ.get("ACTION_SERVER_HOST", "127.0.0.1")
PORT = int(os.environ.get("ACTION_SERVER_PORT", "48100"))

COMMANDS = {
    "status": ["openclaw", "gateway", "status", "--deep"],
    "restart": ["openclaw", "gateway", "restart"],
}


class Handler(BaseHTTPRequestHandler):
    server_version = "OpenClawActionServer/1.0"

    def _send_json(self, status: int, payload: dict) -> None:
        body = json.dumps(payload, ensure_ascii=True).encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Cache-Control", "no-store")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def do_POST(self) -> None:
        prefix = "/action/"
        if not self.path.startswith(prefix):
            self._send_json(HTTPStatus.NOT_FOUND, {"ok": False, "error": "not_found"})
            return

        action = self.path[len(prefix) :].strip().strip("/")
        command = COMMANDS.get(action)
        if command is None:
            self._send_json(HTTPStatus.NOT_FOUND, {"ok": False, "error": "unknown_action"})
            return

        timeout = 60 if action == "restart" else 20
        try:
            completed = subprocess.run(
                command,
                capture_output=True,
                text=True,
                timeout=timeout,
                check=False,
            )
        except subprocess.TimeoutExpired:
            self._send_json(
                HTTPStatus.GATEWAY_TIMEOUT,
                {"ok": False, "action": action, "error": "timeout"},
            )
            return
        except Exception as exc:
            self._send_json(
                HTTPStatus.INTERNAL_SERVER_ERROR,
                {"ok": False, "action": action, "error": str(exc)},
            )
            return

        stdout = (completed.stdout or "").strip()
        stderr = (completed.stderr or "").strip()
        self._send_json(
            HTTPStatus.OK if completed.returncode == 0 else HTTPStatus.BAD_GATEWAY,
            {
                "ok": completed.returncode == 0,
                "action": action,
                "exit_code": completed.returncode,
                "stdout": stdout,
                "stderr": stderr,
            },
        )

    def log_message(self, fmt: str, *args) -> None:
        print(f"action-server: {fmt % args}")


def main() -> None:
    httpd = ThreadingHTTPServer((HOST, PORT), Handler)
    print(f"action-server: listening on http://{HOST}:{PORT}")
    httpd.serve_forever()


if __name__ == "__main__":
    main()
