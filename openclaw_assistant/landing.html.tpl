<!doctype html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>OpenClaw HAOS 插件</title>
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
      --bg: #eef4fb;
      --bg2: rgba(255, 255, 255, 0.92);
      --bg3: #f3f7fc;
      --bg4: #e7eef8;
      --border: #d9e3ef;
      --border2: #afc2da;
      --text: #162235;
      --text2: #465a73;
      --text3: #73869f;
      --green: #157347;
      --green-bg: #ebfbf1;
      --green-border: #9fe5b8;
      --blue: #1859d1;
      --blue-bg: #ebf3ff;
      --blue-border: #a7c7ff;
      --amber: #b86507;
      --amber-bg: #fff4e4;
      --amber-border: #f4c27d;
      --red: #c62828;
      --red-bg: #fff1f1;
      --red-border: #ffb4b4;
      --shadow: 0 20px 50px rgba(25, 44, 72, 0.08);
      --shadow-soft: 0 10px 24px rgba(25, 44, 72, 0.05);
      --radius: 18px;
      --radius-sm: 12px;
    }
    body {
      font-family: "Segoe UI Variable", "Segoe UI", "PingFang SC", "Microsoft YaHei", system-ui, sans-serif;
      background:
        radial-gradient(circle at top left, rgba(59, 130, 246, 0.12), transparent 28%),
        radial-gradient(circle at top right, rgba(16, 185, 129, 0.10), transparent 22%),
        linear-gradient(180deg, #f8fbff 0%, #eef4fb 48%, #edf3f8 100%);
      color: var(--text);
      padding: 16px;
      font-size: 14px;
      line-height: 1.5;
    }
    a, button { font: inherit; }
    h2 { font-size: 20px; font-weight: 700; color: var(--text); letter-spacing: -0.02em; }
    .page { max-width: 920px; margin: 0 auto; display: flex; flex-direction: column; gap: 14px; }
    .header {
      display: flex;
      align-items: center;
      gap: 14px;
      padding: 18px 20px;
      border: 1px solid rgba(217, 227, 239, 0.85);
      border-radius: 22px;
      background: linear-gradient(135deg, rgba(255, 255, 255, 0.95), rgba(244, 249, 255, 0.88));
      box-shadow: var(--shadow);
      backdrop-filter: blur(8px);
    }
    .header-logo {
      width: 52px;
      height: 52px;
      border-radius: 16px;
      display: flex;
      align-items: center;
      justify-content: center;
      background: linear-gradient(135deg, #2463eb, #15a36d);
      box-shadow: 0 14px 28px rgba(36, 99, 235, 0.22);
      flex-shrink: 0;
      position: relative;
      overflow: hidden;
    }
    .header-logo::before {
      content: "";
      position: absolute;
      inset: 1px;
      border-radius: 15px;
      background: linear-gradient(180deg, rgba(255,255,255,0.24), rgba(255,255,255,0.03));
      pointer-events: none;
    }
    .logo-mark {
      position: relative;
      width: 28px;
      height: 28px;
      border-radius: 50%;
      background: radial-gradient(circle at 35% 30%, #ffb2a4, #ef4444 55%, #b91c1c 100%);
      box-shadow: inset 0 -3px 0 rgba(0,0,0,0.12);
    }
    .logo-mark::before,
    .logo-mark::after {
      content: "";
      position: absolute;
      width: 7px;
      height: 10px;
      background: #ef4444;
      border-radius: 8px 8px 2px 2px;
      top: -4px;
    }
    .logo-mark::before {
      left: 4px;
      transform: rotate(-30deg);
    }
    .logo-mark::after {
      right: 4px;
      transform: rotate(30deg);
    }
    .logo-eye {
      position: absolute;
      top: 9px;
      width: 4px;
      height: 4px;
      border-radius: 50%;
      background: #082f49;
      box-shadow: 0 0 0 1px rgba(255,255,255,0.35);
    }
    .logo-eye.left { left: 7px; }
    .logo-eye.right { right: 7px; }
    .logo-foot {
      position: absolute;
      bottom: -3px;
      width: 4px;
      height: 6px;
      border-radius: 3px;
      background: #991b1b;
    }
    .logo-foot.f1 { left: 7px; }
    .logo-foot.f2 { left: 12px; }
    .logo-foot.f3 { right: 12px; }
    .logo-foot.f4 { right: 7px; }
    .header-info { flex: 1; }
    .header-info h2 { margin-bottom: 4px; }
    .header-info .sub { font-size: 13px; color: var(--text3); }
    .card {
      position: relative;
      overflow: hidden;
      background: var(--bg2);
      border: 1px solid rgba(217, 227, 239, 0.88);
      border-radius: var(--radius);
      padding: 16px 18px;
      box-shadow: var(--shadow-soft);
      backdrop-filter: blur(8px);
    }
    .card::before {
      content: "";
      position: absolute;
      inset: 0 0 auto 0;
      height: 1px;
      background: linear-gradient(90deg, rgba(255,255,255,0), rgba(36,99,235,0.26), rgba(255,255,255,0));
      pointer-events: none;
    }
    .card-title {
      font-size: 11px;
      font-weight: 700;
      color: var(--text3);
      text-transform: uppercase;
      letter-spacing: .08em;
      margin-bottom: 12px;
    }
    .badge {
      display: inline-flex;
      align-items: center;
      gap: 4px;
      padding: 4px 10px;
      border-radius: 999px;
      font-size: 11px;
      font-weight: 700;
      white-space: nowrap;
    }
    .badge-green { background: var(--green-bg); color: var(--green); border: 1px solid var(--green-border); }
    .badge-blue { background: var(--blue-bg); color: var(--blue); border: 1px solid var(--blue-border); }
    .badge-amber { background: var(--amber-bg); color: var(--amber); border: 1px solid var(--amber-border); }
    .badge-gray { background: var(--bg3); color: var(--text2); border: 1px solid var(--border); }
    .status-row { display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 10px; margin-bottom: 14px; }
    .status-left { display: flex; align-items: center; gap: 8px; }
    .dot { width: 8px; height: 8px; border-radius: 50%; flex-shrink: 0; }
    .dot-green { background: var(--green); box-shadow: 0 0 6px var(--green); }
    .dot-amber { background: var(--amber); }
    .dot-red { background: var(--red); }
    .status-text { font-size: 18px; font-weight: 700; letter-spacing: -0.01em; }
    .status-badges { display: flex; gap: 6px; flex-wrap: wrap; }
    .metrics { display: grid; grid-template-columns: repeat(3, 1fr); gap: 12px; margin-bottom: 2px; }
    .metric {
      background: linear-gradient(180deg, rgba(248, 251, 255, 0.98), rgba(238, 244, 251, 0.95));
      border: 1px solid rgba(217, 227, 239, 0.9);
      border-radius: var(--radius-sm);
      padding: 14px 14px 12px;
      box-shadow: inset 0 1px 0 rgba(255,255,255,0.7);
    }
    .metric-label { font-size: 11px; color: var(--text3); margin-bottom: 6px; font-weight: 700; text-transform: uppercase; letter-spacing: .06em; }
    .metric-value { font-size: 36px; line-height: 1; font-weight: 700; color: var(--text); letter-spacing: -0.04em; }
    .metric-sub { font-size: 12px; color: var(--text2); margin-top: 8px; }
    .bar-wrap { height: 5px; background: var(--border); border-radius: 999px; margin-top: 10px; overflow: hidden; }
    .bar { height: 5px; border-radius: 999px; transition: width .3s; }
    .bar-green { background: var(--green); }
    .bar-amber { background: var(--amber); }
    .bar-red { background: var(--red); }
    .kv-list { display: flex; flex-direction: column; }
    .kv { display: flex; align-items: center; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid var(--border); gap: 12px; }
    .kv:last-child { border-bottom: none; }
    .kv-key { color: var(--text2); white-space: nowrap; flex-shrink: 0; }
    .kv-val { color: var(--text); font-weight: 500; display: flex; align-items: center; gap: 6px; flex-wrap: wrap; justify-content: flex-end; }
    .mono { font-family: ui-monospace, monospace; font-size: 12px; color: var(--text2); }
    .copy-btn {
      padding: 5px 10px;
      border: 1px solid var(--border2);
      border-radius: 999px;
      background: rgba(255,255,255,0.88);
      color: var(--text2);
      cursor: pointer;
      font-size: 11px;
      font-weight: 700;
      transition: all .18s ease;
    }
    .copy-btn:hover, .btn:hover {
      background: #e4eefb;
      color: var(--text);
      border-color: #95b3da;
      transform: translateY(-1px);
    }
    .btn-grid { display: flex; gap: 10px; flex-wrap: wrap; }
    .btn {
      padding: 10px 16px;
      border-radius: 14px;
      font-size: 13px;
      font-weight: 700;
      cursor: pointer;
      border: 1px solid var(--border2);
      background: linear-gradient(180deg, #ffffff, #f1f6fd);
      color: var(--text);
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      gap: 6px;
      box-shadow: 0 4px 10px rgba(25, 44, 72, 0.04);
      transition: all .18s ease;
    }
    .btn-primary {
      background: linear-gradient(135deg, #1c63e8, #2563eb 55%, #17a56d);
      color: #fff;
      border-color: transparent;
      box-shadow: 0 12px 26px rgba(28, 99, 232, 0.22);
    }
    .btn-primary:hover { background: linear-gradient(135deg, #1957cf, #1f4db4 55%, #138958); color: #fff; }
    .divider { border: none; border-top: 1px solid var(--border); margin: 14px 0; }
    .hero { display: flex; flex-direction: column; gap: 10px; }
    .hero-title { font-size: 22px; font-weight: 700; letter-spacing: -0.03em; }
    .hero-sub { color: var(--text2); font-size: 13px; line-height: 1.8; }
    .diag-row { display: flex; align-items: center; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid var(--border); font-size: 13px; }
    .diag-row:last-child { border-bottom: none; }
    .diag-ok { color: var(--green); }
    .diag-warn { color: var(--amber); }
    .diag-err { color: var(--red); }
    .diag-muted { color: var(--text3); }
    .banner { padding: 12px 14px; border-radius: 14px; margin: 0; font-size: 13px; line-height: 1.7; box-shadow: var(--shadow-soft); }
    .banner-warn { background: var(--amber-bg); border: 1px solid var(--amber-border); }
    .banner-err { background: var(--red-bg); border: 1px solid var(--red-border); }
    .banner-info { background: var(--blue-bg); border: 1px solid var(--blue-border); }
    .banner-ok { background: var(--green-bg); border: 1px solid var(--green-border); }
    .term-wrap { border: 1px solid var(--border); border-radius: 16px; overflow: hidden; height: 55vh; min-height: 320px; margin-top: 2px; box-shadow: inset 0 1px 0 rgba(255,255,255,0.6); }
    .term-wrap iframe { width: 100%; height: 100%; border: 0; background: #000; }
    details { border: 1px solid var(--border); border-radius: var(--radius); overflow: hidden; background: rgba(255,255,255,0.84); box-shadow: var(--shadow-soft); }
    details > summary { cursor: pointer; padding: 12px 16px; font-size: 13px; color: var(--text2); font-weight: 700; background: rgba(255,255,255,0.9); user-select: none; list-style: none; display: flex; justify-content: space-between; align-items: center; }
    details > summary::after { content: "+"; font-size: 16px; color: var(--text3); }
    details[open] > summary::after { content: "-"; }
    .details-body { padding: 14px 16px; background: #f8fbff; font-size: 13px; color: var(--text2); line-height: 1.8; border-top: 1px solid var(--border); }
    .details-body pre { background: #eef4fb; padding: 10px 12px; border-radius: 12px; overflow-x: auto; font-size: 12px; font-family: ui-monospace, monospace; margin: 6px 0; }
    .details-body code { background: #eef4fb; padding: 1px 5px; border-radius: 6px; font-size: 12px; font-family: ui-monospace, monospace; }
    .details-body ol, .details-body ul { padding-left: 20px; line-height: 1.9; }
    .hidden { display: none !important; }
    @media (max-width: 700px) {
      body { padding: 10px; }
      .header { padding: 14px 14px; border-radius: 18px; }
      .header-logo { width: 44px; height: 44px; font-size: 20px; border-radius: 14px; }
      .metrics { grid-template-columns: 1fr; }
      .kv { align-items: flex-start; flex-direction: column; }
      .kv-val { justify-content: flex-start; }
      .metric-value { font-size: 30px; }
      .btn { width: 100%; justify-content: center; }
    }
  </style>
</head>
<body>
<div class="page">
  <div class="header">
    <div class="header-logo" aria-hidden="true">
      <div class="logo-mark">
        <span class="logo-eye left"></span>
        <span class="logo-eye right"></span>
        <span class="logo-foot f1"></span>
        <span class="logo-foot f2"></span>
        <span class="logo-foot f3"></span>
        <span class="logo-foot f4"></span>
      </div>
    </div>
    <div class="header-info">
      <h2>OpenClaw HAOS 插件</h2>
      <div class="sub">Home Assistant 插件 | 版本 __ADDON_VERSION__</div>
    </div>
    <span class="badge badge-gray" id="modeBadge">__ACCESS_MODE__</span>
  </div>

  <div class="card">
    <div class="card-title">服务状态</div>
    <div class="status-row">
      <div class="status-left">
        <div class="dot dot-amber" id="statusDot"></div>
        <span class="status-text" id="statusText">检查中...</span>
      </div>
      <div class="status-badges" id="statusBadges"></div>
    </div>
    <div class="metrics">
      <div class="metric">
        <div class="metric-label">磁盘</div>
        <div class="metric-value">__DISK_PCT__</div>
        <div class="metric-sub">__DISK_USED__ / __DISK_TOTAL__</div>
        <div class="bar-wrap"><div class="bar" id="diskBar" style="width:0%"></div></div>
      </div>
      <div class="metric">
        <div class="metric-label">内存</div>
        <div class="metric-value">__MEM_PCT__</div>
        <div class="metric-sub">__MEM_USED__ / __MEM_TOTAL__</div>
        <div class="bar-wrap"><div class="bar" id="memBar" style="width:0%"></div></div>
      </div>
      <div class="metric">
        <div class="metric-label">CPU</div>
        <div class="metric-value">__CPU_PCT__%</div>
        <div class="metric-sub">1 分钟负载参考</div>
        <div class="bar-wrap"><div class="bar" id="cpuBar" style="width:0%"></div></div>
      </div>
    </div>
  </div>

  <div class="banner banner-err hidden" id="diskBanner">
    磁盘空间偏低。可在终端中运行 <code>oc-cleanup</code>，或在 HA 主机 Shell 里清理 Docker 镜像。
  </div>

  <div class="banner banner-warn hidden" id="migrationBanner">
    <code>access_mode: custom</code> 可能还需要额外的安全上下文配置。对浏览器和手机来说，<b>lan_https</b> 是最简单的受支持方案。
  </div>

  <div class="card">
    <div class="card-title">版本与访问</div>
    <div class="kv-list">
      <div class="kv">
        <span class="kv-key">OpenClaw</span>
        <span class="kv-val"><span class="badge badge-blue">__OPENCLAW_VERSION__</span></span>
      </div>
      <div class="kv">
        <span class="kv-key">Node.js</span>
        <span class="kv-val"><span class="badge badge-green">__NODE_VERSION__</span></span>
      </div>
      <div class="kv">
        <span class="kv-key">网关模式</span>
        <span class="kv-val"><span class="badge badge-gray">__GATEWAY_MODE__</span></span>
      </div>
      <div class="kv">
        <span class="kv-key">配置目录</span>
        <span class="kv-val mono">/config/.openclaw</span>
      </div>
      <div class="kv">
        <span class="kv-key">网关地址</span>
        <span class="kv-val">
          <span class="mono" id="gatewayUrlText">__GATEWAY_PUBLIC_URL__</span>
          <button class="copy-btn" id="gatewayCopyBtn">复制</button>
        </span>
      </div>
      <div class="kv" id="tokenRow">
        <span class="kv-key">网关令牌</span>
        <span class="kv-val">
          <span class="mono" id="tokenDisplay">已隐藏</span>
          <button class="copy-btn" id="tokenRevealBtn">显示</button>
          <button class="copy-btn hidden" id="tokenCopyBtn">复制</button>
        </span>
      </div>
      <div class="kv">
        <span class="kv-key">端口</span>
        <span class="kv-val">
          <span class="badge badge-blue">网关 __GATEWAY_PORT__</span>
          <span class="badge badge-gray">Ingress 48099</span>
          <span class="badge badge-gray">终端 __TERMINAL_PORT__</span>
        </span>
      </div>
    </div>
  </div>

  <div class="card">
    <div class="hero">
      <div class="hero-title">HAOS 控制中心</div>
      <div class="hero-sub">
        这个页面是 OpenClaw 在 Home Assistant 里的统一入口。你可以在新标签页打开原生 Gateway 控制界面，也可以留在这里查看健康状态、令牌、终端和访问诊断。
      </div>
    </div>
    <hr class="divider">
    <div class="card-title">操作</div>
    <div class="btn-grid">
      <a class="btn btn-primary" id="gwBtn" href="__GATEWAY_PUBLIC_URL____GW_PUBLIC_URL_PATH__" target="_blank" rel="noopener noreferrer">打开原生 Gateway 界面</a>
      <a class="btn" href="./terminal/" target="_self">打开终端</a>
      <a class="btn hidden" id="certBtn" href="" target="_blank" rel="noopener noreferrer">下载 CA 证书</a>
      <button class="btn" id="gatewayStatusBtn">查看网关状态</button>
      <button class="btn" id="gatewayRestartBtn">重启网关</button>
      <button class="btn" id="checkUpdateBtn">检查 npm 版本</button>
    </div>
    <hr class="divider">
    <div class="card-title">终端快捷命令</div>
    <div class="btn-grid">
      <button class="btn" data-term-cmd="openclaw devices list">devices list</button>
      <button class="btn" data-term-cmd="openclaw devices approve --latest">approve --latest</button>
      <button class="btn" data-term-cmd="openclaw onboard">onboard</button>
      <button class="btn" data-term-cmd="openclaw doctor --fix">doctor --fix</button>
      <button class="btn" data-term-cmd="openclaw health --json">health --json</button>
      <button class="btn" data-term-cmd="openclaw status --deep">status --deep</button>
      <button class="btn" data-term-cmd="openclaw logs --follow">logs --follow</button>
      <button class="btn" data-term-cmd="openclaw security audit --deep">security audit</button>
      <button class="btn" data-term-cmd="openclaw memory status --deep">memory status</button>
      <button class="btn" data-term-cmd="jq -r '.gateway.auth.token' /config/.openclaw/openclaw.json">read token</button>
    </div>
    <div class="hero-sub" style="margin-top:8px">
      点击后会把命令填入下方终端，不会自动执行；按回车即可运行。
    </div>
    <hr class="divider">
    <div id="actionFeedback" style="margin-top:8px;font-size:12px;color:var(--text2)"></div>
  </div>

  <div class="card">
    <div class="card-title">快速诊断</div>
    <div class="diag-row">
      <span>网关健康</span>
      <span class="diag-muted" id="diagGateway">检查中...</span>
    </div>
    <div class="diag-row">
      <span>访问模式</span>
      <span id="diagAccess" class="diag-muted">__ACCESS_MODE__</span>
    </div>
    <div class="diag-row">
      <span>安全上下文</span>
      <span id="diagSecure" class="diag-muted">检查中...</span>
    </div>
    <div class="diag-row">
      <span>MCP</span>
      <span class="diag-muted" id="diagMcp">__MCP_STATUS__</span>
    </div>
  </div>

  <div id="wizardCard" class="hidden"></div>

  <details>
    <summary>令牌与连接帮助</summary>
    <div class="details-body">
      在 HAOS 中，这个落地页就是总控入口。使用 <b>打开原生 Gateway 界面</b> 可在新标签页进入 OpenClaw 完整控制界面。如果网关要求输入令牌，也可以在插件终端里读取：
      <pre>jq -r '.gateway.auth.token' /config/.openclaw/openclaw.json</pre>
      这个页面调用的是 OpenClaw 官方网关控制命令：
      <pre>openclaw gateway status
openclaw gateway restart</pre>
      如果需要设备配对：
      <pre>openclaw devices list
openclaw devices approve &lt;requestId&gt;</pre>
    </div>
  </details>

  <details>
    <summary>MCP 设置</summary>
    <div class="details-body">
      <b>自动配置</b>
      <ol>
        <li>创建一个 Home Assistant 长期访问令牌。</li>
        <li>填写 <code>homeassistant_token</code>。</li>
        <li>启用 <code>auto_configure_mcp</code>。</li>
        <li>重启插件。</li>
      </ol>
      <b>手动配置</b>
      <pre>mcporter config add HA "http://localhost:8123/api/mcp" \
  --header "Authorization=Bearer YOUR_TOKEN" \
  --scope home</pre>
    </div>
  </details>

  <div class="card" style="padding:12px">
    <div class="card-title" style="margin-bottom:8px">终端</div>
    <div class="term-wrap">
      <iframe id="termFrame" src="./terminal/" title="终端" loading="lazy"></iframe>
    </div>
  </div>
</div>

<script>
(function () {
  var ACCESS_MODE = __ACCESS_MODE_JSON__;
  var GATEWAY_MODE = __GATEWAY_MODE_JSON__;
  var DISK_PCT = __DISK_PCT_JSON__;
  var DISK_AVAIL = __DISK_AVAIL_JSON__;
  var MEM_PCT = __MEM_PCT_JSON__;
  var CPU_PCT = __CPU_PCT_JSON__;
  var HTTPS_PORT = __HTTPS_PORT_JSON__;
  var GW_URL = __GW_URL_JSON__;
  var TOKEN_AVAILABLE = __TOKEN_AVAILABLE_JSON__ === "true";
  var OC_VER = __OPENCLAW_VERSION_JSON__;

  function $(id) { return document.getElementById(id); }
  function ingressUrl(path) {
    var cleaned = String(path || "").replace(/^\/+/, "");
    var base = window.location.href.split("#")[0];
    if (!/\/$/.test(base)) {
      base += "/";
    }
    return new URL(cleaned, base).toString();
  }
  function withTokenHash(url, token) {
    if (!url || !token) { return url; }
    var base = String(url).replace(/#.*$/, "");
    return base + "#token=" + encodeURIComponent(token);
  }
  function findTerminalTextarea(doc) {
    if (!doc) { return null; }
    return doc.querySelector(".xterm-helper-textarea, textarea.xterm-helper-textarea, textarea");
  }
  function injectCommandToTerminal(command) {
    var frame = $("termFrame");
    var feedback = $("actionFeedback");
    if (!frame || !frame.contentWindow) {
      feedback.textContent = "终端尚未就绪，无法填入命令。";
      return;
    }
    try {
      var doc = frame.contentWindow.document;
      var input = findTerminalTextarea(doc);
      if (!input) {
        feedback.textContent = "终端输入框暂不可用，请先点击一次下方终端。";
        return;
      }
      frame.contentWindow.focus();
      input.focus();
      input.value = command;
      input.dispatchEvent(new InputEvent("input", {
        bubbles: true,
        cancelable: true,
        data: command,
        inputType: "insertText"
      }));
      feedback.textContent = "命令已填入终端：" + command;
    } catch (_err) {
      feedback.textContent = "无法直接写入终端，请先点击终端后再试。";
    }
  }
  function setButtonState(id, disabled) {
    var el = $(id);
    if (!el) { return; }
    el.disabled = disabled;
    if (disabled) { el.classList.add("hidden"); }
  }
  function escapeHtml(text) {
    return String(text)
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;");
  }
  function barColor(p) { return p >= 90 ? "bar-red" : p >= 70 ? "bar-amber" : "bar-green"; }
  function setBar(id, pct) {
    var el = $(id);
    if (!el || Number.isNaN(pct)) { return; }
    el.style.width = Math.min(pct, 100) + "%";
    el.className = "bar " + barColor(pct);
  }
  function setHealthState(ok, message) {
    var dot = $("statusDot");
    var txt = $("statusText");
    var badges = $("statusBadges");
    if (ok) {
      dot.className = "dot dot-green";
      txt.textContent = message || "运行中";
      txt.style.color = "var(--green)";
      badges.innerHTML = '<span class="badge badge-green">网关正常</span>';
      $("diagGateway").textContent = "正常";
      $("diagGateway").className = "diag-ok";
    } else {
      dot.className = "dot dot-red";
      txt.textContent = message || "不可用";
      txt.style.color = "var(--red)";
      badges.innerHTML = '<span class="badge badge-amber">检查配置</span>';
      $("diagGateway").textContent = "不可用";
      $("diagGateway").className = "diag-err";
    }
  }

  if (DISK_PCT) {
    var dp = parseInt(DISK_PCT, 10);
    setBar("diskBar", dp);
    if (dp >= 75) {
      $("diskBanner").classList.remove("hidden");
      $("diskBanner").textContent = "磁盘已使用 " + DISK_PCT + "，剩余空间 " + DISK_AVAIL + "。";
    }
  }
  if (MEM_PCT) { setBar("memBar", parseInt(MEM_PCT, 10)); }
  if (CPU_PCT) { setBar("cpuBar", parseFloat(CPU_PCT)); }

  if (ACCESS_MODE === "custom") {
    $("migrationBanner").classList.remove("hidden");
  }

  var isSecure =
    location.protocol === "https:" ||
    location.hostname === "localhost" ||
    location.hostname === "127.0.0.1" ||
    location.hostname === "::1";
  $("diagSecure").textContent = isSecure ? "安全" : "不安全";
  $("diagSecure").className = isSecure ? "diag-ok" : "diag-err";

  var modeColors = {
    lan_https: "badge-green",
    tailnet_https: "badge-green",
    lan_reverse_proxy: "badge-blue",
    local_only: "badge-gray",
    custom: "badge-amber"
  };
  $("modeBadge").className = "badge " + (modeColors[ACCESS_MODE] || "badge-gray");

  if (ACCESS_MODE === "lan_https" && HTTPS_PORT) {
    var certBtn = $("certBtn");
    certBtn.href = "https://" + location.hostname + ":" + HTTPS_PORT + "/cert/ca.crt";
    certBtn.classList.remove("hidden");
  }

  var mcpEl = $("diagMcp");
  if (mcpEl) {
    var st = mcpEl.textContent.trim().toLowerCase();
    if (st === "registered" || st === "enabled" || st === "configured") {
      mcpEl.textContent = "已注册";
      mcpEl.className = "diag-ok";
    } else if (!st) {
      mcpEl.textContent = "未配置";
      mcpEl.className = "diag-muted";
    }
  }

  var accessEl = $("diagAccess");
  if (["lan_https", "tailnet_https", "lan_reverse_proxy"].indexOf(ACCESS_MODE) >= 0) {
    accessEl.className = "diag-ok";
  } else if (ACCESS_MODE === "local_only") {
    accessEl.className = "diag-muted";
  } else {
    accessEl.className = "diag-warn";
  }
  accessEl.textContent = ACCESS_MODE;

  if (!GW_URL) {
    $("gatewayCopyBtn").disabled = true;
    $("gwBtn").classList.add("hidden");
  }

  if (!TOKEN_AVAILABLE) {
    $("tokenRow").classList.add("hidden");
  }

  if (GATEWAY_MODE === "remote") {
    setButtonState("gatewayStatusBtn", true);
    setButtonState("gatewayRestartBtn", true);
  }

  async function checkGateway() {
    if (GATEWAY_MODE === "remote" && !GW_URL) {
      setHealthState(false, "请设置 gateway_public_url");
      return;
    }
    var url = GATEWAY_MODE === "remote" ? GW_URL + "/health" : ingressUrl("health");
    try {
      var res = await fetch(url, { cache: "no-cache" });
      if (!res.ok) { throw new Error("HTTP " + res.status); }
      var data = null;
      try {
        data = await res.json();
      } catch (_parseErr) {
        data = null;
      }
      if (data && data.ok === false) {
        throw new Error(data.error || "health");
      }
      setHealthState(true, GATEWAY_MODE === "remote" ? "远程网关可达" : "运行中");
    } catch (_err) {
      setHealthState(false, GATEWAY_MODE === "remote" ? "远程网关不可达" : "不可用");
    }
  }

  checkGateway();
  setInterval(checkGateway, 30000);

  var tokenValue = "";
  var gwBtn = $("gwBtn");

  if (gwBtn) {
    gwBtn.addEventListener("click", function (event) {
      if (!GW_URL || !TOKEN_AVAILABLE) { return; }
      event.preventDefault();

      function openWithToken(token) {
        window.open(withTokenHash(gwBtn.href, token), "_blank", "noopener,noreferrer");
      }

      if (tokenValue) {
        openWithToken(tokenValue);
        return;
      }

      fetch(ingressUrl("token"), { cache: "no-cache" })
        .then(function (r) {
          if (!r.ok) { throw new Error("token"); }
          return r.text();
        })
        .then(function (t) {
          tokenValue = t.trim();
          if (!tokenValue) { throw new Error("empty"); }
          $("tokenDisplay").textContent = tokenValue;
          $("tokenRevealBtn").classList.add("hidden");
          $("tokenCopyBtn").classList.remove("hidden");
          openWithToken(tokenValue);
        })
        .catch(function () {
          window.open(gwBtn.href, "_blank", "noopener,noreferrer");
        });
    });
  }

  $("tokenRevealBtn") && $("tokenRevealBtn").addEventListener("click", function () {
    if (tokenValue) {
      $("tokenDisplay").textContent = tokenValue;
      $("tokenRevealBtn").classList.add("hidden");
      $("tokenCopyBtn").classList.remove("hidden");
      return;
    }
    fetch(ingressUrl("token"), { cache: "no-cache" })
      .then(function (r) {
        if (!r.ok) { throw new Error("token"); }
        return r.text();
      })
      .then(function (t) {
        tokenValue = t.trim();
        if (!tokenValue) { throw new Error("empty"); }
        $("tokenDisplay").textContent = tokenValue;
        $("tokenRevealBtn").classList.add("hidden");
        $("tokenCopyBtn").classList.remove("hidden");
      })
      .catch(function () {
        $("tokenDisplay").textContent = "可在终端里用 jq 读取。";
      });
  });

  $("tokenCopyBtn") && $("tokenCopyBtn").addEventListener("click", function () {
    if (!tokenValue) { return; }
    navigator.clipboard.writeText(tokenValue).then(function () {
      $("tokenCopyBtn").textContent = "已复制";
      setTimeout(function () { $("tokenCopyBtn").textContent = "复制"; }, 1500);
    });
  });

  $("gatewayCopyBtn").addEventListener("click", function () {
    if (!GW_URL) { return; }
    navigator.clipboard.writeText(GW_URL).then(function () {
      $("gatewayCopyBtn").textContent = "已复制";
      setTimeout(function () { $("gatewayCopyBtn").textContent = "复制"; }, 1500);
    });
  });

  function runGatewayAction(action, label) {
    var fb = $("actionFeedback");
    fb.textContent = label + "中...";
    fetch(ingressUrl("action/" + action), {
      method: "POST",
      cache: "no-cache"
    })
      .then(function (r) {
        return r.json().then(function (data) {
          return { ok: r.ok, data: data };
        });
      })
      .then(function (result) {
        var data = result.data || {};
        var output = data.stdout || data.stderr || "";
        if (!result.ok || !data.ok) {
          fb.innerHTML = "<b>" + escapeHtml(label) + "失败。</b><br><pre>" + escapeHtml(output || "无输出") + "</pre>";
          return;
        }
        fb.innerHTML = "<b>" + escapeHtml(label) + "完成。</b>" +
          (output ? "<br><pre>" + escapeHtml(output) + "</pre>" : "");
        if (action === "restart") {
          setTimeout(checkGateway, 1500);
        }
      })
      .catch(function () {
        fb.textContent = label + "失败：无法访问本地动作服务。";
      });
  }

  $("gatewayStatusBtn").addEventListener("click", function () {
    runGatewayAction("status", "查看网关状态");
  });

  $("gatewayRestartBtn").addEventListener("click", function () {
    runGatewayAction("restart", "重启网关");
  });

  $("checkUpdateBtn").addEventListener("click", function () {
    var fb = $("actionFeedback");
    fb.textContent = "正在检查 npm 仓库...";
    fetch("https://registry.npmjs.org/openclaw/latest", { cache: "no-cache" })
      .then(function (r) {
        if (!r.ok) { throw new Error("npm"); }
        return r.json();
      })
      .then(function (d) {
        if (d.version && d.version !== OC_VER) {
          fb.innerHTML = "npm 最新版本：<b>" + d.version + "</b>（当前：" + OC_VER + "）。";
        } else {
          fb.textContent = "当前内置版本已是最新：" + OC_VER + "。";
        }
      })
      .catch(function () {
        fb.textContent = "当前无法连接到 npm。";
      });
  });

  Array.prototype.forEach.call(document.querySelectorAll("[data-term-cmd]"), function (btn) {
    btn.addEventListener("click", function () {
      injectCommandToTerminal(btn.getAttribute("data-term-cmd") || "");
    });
  });

  var wizard = $("wizardCard");
  if (ACCESS_MODE === "lan_https") {
    wizard.className = "banner banner-ok";
    wizard.textContent = "内置 HTTPS 代理已启用。如果希望手机或平板浏览器信任本地证书，请安装 CA 证书。";
  } else if (ACCESS_MODE === "local_only") {
    wizard.className = "banner banner-info";
    wizard.textContent = "Gateway 当前只绑定在本机回环地址。如果需要局域网访问，请使用 lan_https 或反向代理。";
  } else if (GATEWAY_MODE === "remote") {
    wizard.className = "banner banner-info";
      wizard.textContent = "这个插件当前连接的是远程网关。请确认 gateway_public_url 指向真实的远程控制界面。";
  }
})();
</script>
</body>
</html>
