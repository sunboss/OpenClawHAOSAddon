FROM node:24-bookworm-slim

# Base image: node:24-bookworm-slim (official Node.js 24 LTS on Debian Bookworm).
# - Aligns with upstream openclaw recommended runtime (Node 24).
# - Includes Node.js + npm pre-installed; no NodeSource setup needed.
# - glibc-based: avoids musl-related native module issues (clipboard, node-llama-cpp).

# Install base packages
# build-essential provides gcc/cc needed by Homebrew for OpenClaw's brew-managed dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    git \
    openssh-client \
    ca-certificates \
    tzdata \
    jq \
    curl \
    tar \
    xz-utils \
    file \
    python3 \
    nginx \
    gnupg \
    build-essential \
    iproute2 \
    procps \
    sudo \
    util-linux \
    vim \
    nano \
    fd-find \
    ripgrep \
    rsync \
    bat \
    less \
    openssl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install ttyd (web terminal) - not in Debian repos, download binary
# Docker TARGETARCH: amd64, arm64, arm/v7 -> ttyd filenames: x86_64, aarch64, armhf
ARG TARGETARCH
RUN ARCH=$(echo ${TARGETARCH:-$(dpkg --print-architecture)} | sed 's|arm64|aarch64|;s|arm/v7|armhf|;s|armv7|armhf|;s|amd64|x86_64|') \
    && echo "Downloading ttyd for arch: ${ARCH}" \
    && curl -fsSL "https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.${ARCH}" -o /usr/local/bin/ttyd \
    && chmod +x /usr/local/bin/ttyd

# Verify Node.js 24 is present (fail fast if base image changes)
RUN node -v | grep -E '^v24\.' || (echo "ERROR: Expected Node.js v24, got $(node -v)" && exit 1) \
    && npm -v

# Install pnpm globally (required by some OpenClaw skills like clawhub)
RUN npm install -g pnpm && pnpm -v

# Install MCPorter globally so the add-on can register native MCP servers
# (for example Home Assistant's built-in /api/mcp endpoint) during startup.
RUN npm install -g mcporter \
    && mcporter --version

# Install Homebrew (Linuxbrew) for OpenClaw skill dependencies
# Homebrew is optional - some skills need CLI tools like gemini, aider, etc.
# NOTE: Homebrew requires CPU with SSSE3 support (Intel Core 2 or newer, ~2006+)
# If installation fails (e.g., older CPUs), the add-on will still work but some skills may not install
ENV HOMEBREW_NO_AUTO_UPDATE=1 \
    HOMEBREW_NO_INSTALL_CLEANUP=1 \
    HOMEBREW_NO_ANALYTICS=1

RUN useradd -m -s /bin/bash linuxbrew \
    && mkdir -p /home/linuxbrew/.linuxbrew \
    && chown -R linuxbrew:linuxbrew /home/linuxbrew

USER linuxbrew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || \
    (echo "WARNING: Homebrew installation failed (likely unsupported CPU - requires SSSE3). Some skills may not work." && exit 0)
RUN if [ -d /home/linuxbrew/.linuxbrew/Homebrew ]; then \
    cd /home/linuxbrew/.linuxbrew/Homebrew && \
    git config --global --add safe.directory /home/linuxbrew/.linuxbrew/Homebrew && \
    /home/linuxbrew/.linuxbrew/bin/brew update --force || true; \
    fi
USER root

# Add Homebrew to PATH for all users (wrapper comes first to intercept root calls)
# PATH is set even if brew failed - wrapper will handle missing brew gracefully
ENV PATH="/usr/local/bin:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"

# Copy brew wrapper that allows root to run brew by delegating to linuxbrew user
COPY brew-wrapper.sh /usr/local/bin/brew
RUN chmod +x /usr/local/bin/brew

# Verify brew is available and install gcc (needed for compiling some brew packages)
# Skip if brew installation failed
USER linuxbrew
RUN if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then \
    /home/linuxbrew/.linuxbrew/bin/brew --version && \
    /home/linuxbrew/.linuxbrew/bin/brew install gcc || true; \
    else \
    echo "Skipping gcc installation - Homebrew not available"; \
    fi
USER root

# Install OpenClaw globally; version is pinned via ARG for reproducible builds.
# Bump OPENCLAW_VERSION here (and in config.yaml) when upgrading.
ARG OPENCLAW_VERSION=2026.3.31
RUN npm config set fund false && npm config set audit false \
    && npm install -g openclaw@${OPENCLAW_VERSION} \
    && echo "Installed openclaw@$(openclaw --version 2>/dev/null || echo unknown)"

# Install Chromium via Playwright for CDP-compatible browser automation.
# This ensures the browser version is managed by openclaw/playwright rather than
# the system apt package, avoiding CDP version mismatches.
ENV PLAYWRIGHT_BROWSERS_PATH=/config/.cache/ms-playwright
RUN node $(npm root -g)/openclaw/node_modules/playwright-core/cli.js install chromium \
    || (echo "WARN: Playwright Chromium install failed; falling back to system chromium" && \
        apt-get update && apt-get install -y --no-install-recommends chromium chromium-driver \
        && apt-get clean && rm -rf /var/lib/apt/lists/*)

# Shell aliases and color options for interactive use
RUN tee -a /etc/bash.bashrc <<'EOF'

# Aliases
alias bat="batcat"
alias fd="fdfind"

# Enable colors
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias egrep="grep -E --color=auto"
alias fgrep="grep -F --color=auto"
alias diff="diff --color=auto"
alias ip="ip --color=auto"
if [ -z "${LS_COLORS+x}" ]; then
  export LS_COLORS="di=1;34:ln=1;36:so=1;pi=33:ex=1;32:bd=1;33:cd=1;33:su=1;31:sg=1;31:tw=1;34:ow=1;34"
fi
EOF
COPY run.sh /run.sh
COPY config.yaml /etc/openclaw-addon-config.yaml
COPY oc_config_helper.py /oc_config_helper.py
COPY render_nginx.py /render_nginx.py
COPY action_server.py /action_server.py
COPY oc-cleanup.sh /usr/local/bin/oc-cleanup
COPY openclaw-proxy-shim.cjs /usr/local/lib/openclaw-proxy-shim.cjs
COPY nginx.conf.tpl /etc/nginx/nginx.conf.tpl
COPY landing.html.tpl /etc/nginx/landing.html.tpl
RUN chmod +x /run.sh /oc_config_helper.py /render_nginx.py /action_server.py /usr/local/bin/oc-cleanup \
    && mkdir -p /run/nginx

CMD [ "/run.sh" ]

