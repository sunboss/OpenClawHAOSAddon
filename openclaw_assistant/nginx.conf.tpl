worker_processes 1;

error_log /dev/stderr notice;

events { worker_connections 1024; }

http {
  include       /etc/nginx/mime.types;
  default_type  application/octet-stream;

  __NGINX_ACCESS_LOG__
  error_log /dev/stderr notice;

  sendfile on;
  keepalive_timeout 65;

  server {
    listen 48099;

    location = /terminal {
      return 302 /terminal/;
    }

    location ^~ /terminal/ {
      proxy_pass http://127.0.0.1:__TERMINAL_PORT__;
      proxy_http_version 1.1;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection "upgrade";
      proxy_set_header Host $host;
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header X-Forwarded-For $remote_addr;
      proxy_set_header X-Forwarded-Proto $scheme;
      proxy_read_timeout 3600s;
      proxy_send_timeout 3600s;
    }

    location = / {
      root /etc/nginx/html;
      default_type text/html;
      try_files /index.html =404;
    }

    location = /token {
      alias /etc/nginx/html/gateway.token;
      default_type text/plain;
      add_header Cache-Control "no-store";
    }

    location = /health {
      proxy_pass http://127.0.0.1:48100/health;
      proxy_http_version 1.1;
      proxy_set_header Host $host;
      proxy_set_header X-Forwarded-Proto $scheme;
      proxy_read_timeout 30s;
    }

    location ~ ^/action/(status|restart)$ {
      proxy_pass http://127.0.0.1:48100;
      proxy_http_version 1.1;
      proxy_set_header Host $host;
      proxy_set_header X-Forwarded-Proto $scheme;
      proxy_read_timeout 70s;
    }

    location / {
      return 404;
    }
  }

  __HTTPS_GATEWAY_BLOCK__
}
