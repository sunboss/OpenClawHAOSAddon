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
    .mono-copyable {
      cursor: pointer;
      padding: 2px 6px;
      border-radius: 8px;
      transition: background .18s ease, color .18s ease;
      user-select: all;
    }
    .mono-copyable:hover {
      background: var(--bg4);
      color: var(--text);
    }
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
    .hero-tip {
      margin-top: 2px;
      padding: 10px 12px;
      border-radius: 12px;
      background: linear-gradient(180deg, #fff8ef, #fff2df);
      border: 1px solid var(--amber-border);
      color: var(--amber);
      font-size: 12px;
      line-height: 1.7;
    }
    .guide-grid {
      display: grid;
      grid-template-columns: repeat(2, minmax(0, 1fr));
      gap: 12px;
      margin-top: 4px;
    }
    .guide-card {
      padding: 14px;
      border-radius: 14px;
      border: 1px solid var(--border);
      background: linear-gradient(180deg, rgba(255,255,255,0.96), rgba(242,247,253,0.92));
      box-shadow: inset 0 1px 0 rgba(255,255,255,0.7);
    }
    .guide-card h3 {
      font-size: 13px;
      font-weight: 700;
      color: var(--text);
      margin-bottom: 8px;
    }
    .guide-card ul {
      margin: 0 0 0 18px;
      color: var(--text2);
      font-size: 13px;
      line-height: 1.7;
    }
    .guide-card li + li { margin-top: 4px; }
    .mini-note {
      margin-top: 10px;
      color: var(--text3);
      font-size: 12px;
      line-height: 1.7;
    }
    .section-subtitle {
      font-size: 11px;
      font-weight: 700;
      color: var(--text3);
      text-transform: uppercase;
      letter-spacing: .08em;
      margin: 4px 0 8px;
    }
    .action-panel {
      margin-top: 10px;
      border: 1px solid var(--border);
      border-radius: 16px;
      background: linear-gradient(180deg, rgba(248,251,255,0.96), rgba(239,245,252,0.92));
      box-shadow: inset 0 1px 0 rgba(255,255,255,0.7);
      overflow: hidden;
    }
    .action-panel.state-ok { border-color: var(--green-border); background: linear-gradient(180deg, #f2fff7, #edf9f1); }
    .action-panel.state-warn { border-color: var(--amber-border); background: linear-gradient(180deg, #fff9ef, #fff3e2); }
    .action-panel.state-err { border-color: var(--red-border); background: linear-gradient(180deg, #fff6f6, #fff0f0); }
    #actionPanel { display: none !important; }
    .action-head {
      padding: 10px 14px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 10px;
      border-bottom: 1px solid rgba(217, 227, 239, 0.8);
    }
    .action-title {
      font-size: 13px;
      font-weight: 700;
      color: var(--text);
    }
    .action-body {
      padding: 12px 14px;
      font-size: 13px;
      color: var(--text2);
      line-height: 1.8;
      white-space: pre-wrap;
      word-break: break-word;
    }
    .action-pre {
      margin-top: 8px;
      padding: 12px;
      height: 280px;
      min-height: 280px;
      overflow: auto;
      border-radius: 12px;
      background: rgba(15, 23, 42, 0.94);
      color: #dbeafe;
      font-size: 12px;
      line-height: 1.7;
      font-family: ui-monospace, monospace;
    }
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
      .guide-grid { grid-template-columns: 1fr; }
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

  <div class="kv hidden" id="pidRowPlainTemplate">
    <span class="kv-key">PID</span>
    <span class="kv-val">
      <span class="badge badge-blue">Gateway __GW_PID__</span>
      <span class="badge badge-gray">nginx __NGINX_PID__</span>
      <span class="badge badge-gray">ttyd __TTYD_PID__</span>
      <span class="badge badge-gray">Action __ACTION_PID__</span>
    </span>
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
        <span class="kv-val"><span class="badge badge-gray" id="gatewayModeText">__GATEWAY_MODE__</span></span>
      </div>
      <div class="kv">
        <span class="kv-key">配置目录</span>
        <span class="kv-val mono">/config/.openclaw</span>
      </div>
      <div class="kv">
        <span class="kv-key">网关地址</span>
        <span class="kv-val">
          <span class="mono mono-copyable" id="gatewayUrlText" title="点击复制">__GATEWAY_PUBLIC_URL__</span>
          <button class="copy-btn" id="gatewayCopyBtn">复制</button>
        </span>
      </div>
      <div class="kv" id="tokenRow">
        <span class="kv-key">网关令牌</span>
        <span class="kv-val">
          <span class="mono mono-copyable" id="tokenDisplay" title="点击复制">已隐藏</span>
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
      <div class="kv">
        <span class="kv-key">进程 PID</span>
        <span class="kv-val">
          <span class="badge badge-blue">网关 __GW_PID__</span>
          <span class="badge badge-gray">nginx __NGINX_PID__</span>
          <span class="badge badge-gray">ttyd __TTYD_PID__</span>
          <span class="badge badge-gray">动作 __ACTION_PID__</span>
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
      <div class="hero-tip">
        如果打开原生 Gateway 界面后仍提示设备签名过期，请先清除该站点缓存或改用无痕窗口，再重新打开。
      </div>
      <div class="guide-grid">
        <div class="guide-card">
          <h3>在这里配置</h3>
          <ul>
            <li><code>Home Assistant Token</code>、MCP、访问模式、端口等 add-on 参数</li>
            <li><code>Brave Search</code>、<code>Gemini Memory Search</code> 这类能力开关</li>
            <li>保存并重启 add-on 后自动生效</li>
          </ul>
        </div>
        <div class="guide-card">
          <h3>在终端运行 <code>openclaw onboard</code></h3>
          <ul>
            <li>登录主模型账号 / OAuth</li>
            <li>选择默认聊天模型、channels、hooks</li>
            <li>更适合首次初始化，不建议每次启动都重复操作</li>
          </ul>
        </div>
      </div>
      <div class="mini-note">建议：配置页负责 add-on 参数，<code>openclaw onboard</code> 负责 OpenClaw 自身初始化。</div>
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
    <div class="section-subtitle">配对与初始化</div>
    <div class="btn-grid">
      <button class="btn" data-term-cmd="openclaw devices list">devices list</button>
      <button class="btn" data-term-cmd="openclaw devices approve --latest">approve --latest</button>
      <button class="btn" data-term-cmd="openclaw onboard">onboard</button>
      <button class="btn" data-term-cmd="openclaw doctor --fix">doctor --fix</button>
    </div>
    <div class="section-subtitle">诊断与维护</div>
      <div class="btn-grid">
        <button class="btn" data-term-cmd="openclaw health --json">health --json</button>
        <button class="btn" data-term-cmd="openclaw status --deep">status --deep</button>
        <button class="btn" data-term-cmd="openclaw logs --follow">logs --follow</button>
        <button class="btn" data-term-cmd="tail -f /tmp/openclaw/openclaw-$(date +%F).log">tail gateway log</button>
        <button class="btn" data-term-cmd="mcporter list HA">mcp list</button>
        <button class="btn" data-term-cmd="cat /config/.mcporter/mcporter.json">mcp config</button>
        <button class="btn" data-term-cmd="openclaw security audit --deep">security audit</button>
        <button class="btn" data-term-cmd="openclaw memory status --deep">memory status</button>
        <button class="btn" data-term-cmd="jq -r '.gateway.auth.token' /config/.openclaw/openclaw.json">read token</button>
      </div>
    <div class="section-subtitle">备份与恢复</div>
      <div class="btn-grid">
        <button class="btn" data-term-cmd="ls -la /share/openclaw-backup/latest">backup dir</button>
        <button class="btn" data-term-cmd="mkdir -p /share/openclaw-backup/latest && cp -a /config/.openclaw /share/openclaw-backup/latest/ && cp -a /config/.mcporter /share/openclaw-backup/latest/">backup state</button>
      </div>
    <div class="hero-sub" style="margin-top:6px"><code>/share/openclaw-backup/latest</code></div>
    <div class="hero-sub" style="margin-top:8px">
      点击后会把命令填入下方终端，不会自动执行；按回车即可运行。
    </div>
    <hr class="divider">
    <div id="actionPanel" class="action-panel hidden">
      <div class="action-head">
        <div class="action-title" id="actionTitle">操作结果</div>
        <span class="badge badge-gray" id="actionState">提示</span>
      </div>
      <div class="action-body" id="actionBody"></div>
    </div>
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
    <div class="diag-row hidden" id="diagWebRow">
      <span>Web Search</span>
      <span class="diag-muted" id="diagWeb">-</span>
    </div>
    <div class="diag-row hidden" id="diagMemoryRow">
      <span>Memory Search</span>
      <span class="diag-muted" id="diagMemory">-</span>
    </div>
    <div class="mini-note">这里只显示当前已启用的能力状态；未启用的 MCP / Web Search / Memory Search 会自动隐藏。</div>
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
      <div class="hero-sub" style="margin:8px 0 10px">
        当前镜像如果没有内置 <code>mcporter</code>，页面会明确提示“缺少 mcporter”，这时需要等后续镜像补齐，或在终端里手动提供该工具后再注册。
      </div>
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
  var WEB_SEARCH_ENABLED = __WEB_SEARCH_ENABLED_JSON__ === "true";
  var WEB_SEARCH_PROVIDER = __WEB_SEARCH_PROVIDER_JSON__;
  var MEMORY_SEARCH_ENABLED = __MEMORY_SEARCH_ENABLED_JSON__ === "true";
  var MEMORY_SEARCH_PROVIDER = __MEMORY_SEARCH_PROVIDER_JSON__;
  var MEMORY_SEARCH_MODEL = __MEMORY_SEARCH_MODEL_JSON__;
  var ACCESS_MODE_LABELS = {
    lan_https: "\u5c40\u57df\u7f51 HTTPS",
    tailnet_https: "Tailscale HTTPS",
    lan_reverse_proxy: "\u5c40\u57df\u7f51\u53cd\u5411\u4ee3\u7406",
    local_only: "\u4ec5\u672c\u673a",
    custom: "\u81ea\u5b9a\u4e49"
  };
  var GATEWAY_MODE_LABELS = {
    local: "\u672c\u5730",
    remote: "\u8fdc\u7a0b"
  };

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
  function safeText(value, fallback) {
    var text = String(value == null ? "" : value).trim();
    return text || fallback || "";
  }
  function findTerminalTextarea(doc) {
    if (!doc) { return null; }
    return doc.querySelector(".xterm-helper-textarea, textarea.xterm-helper-textarea, textarea");
  }
  function selectText(el) {
    if (!el) { return; }
    var range = document.createRange();
    range.selectNodeContents(el);
    var sel = window.getSelection();
    sel.removeAllRanges();
    sel.addRange(range);
  }
  function setTextAndSelect(id, text) {
    var el = $(id);
    if (!el) { return; }
    el.textContent = text;
    selectText(el);
  }
  function setActionFeedback(kind, title, body, code) {
    var panel = $("actionPanel");
    var titleEl = $("actionTitle");
    var stateEl = $("actionState");
    var bodyEl = $("actionBody");
    if (!panel || !titleEl || !stateEl || !bodyEl) { return; }
    panel.className = "action-panel state-" + kind;
    titleEl.textContent = title;
    stateEl.textContent = kind === "ok" ? "\u5b8c\u6210" : kind === "warn" ? "\u6ce8\u610f" : "\u5931\u8d25";
    stateEl.className = "badge " + (kind === "ok" ? "badge-green" : kind === "warn" ? "badge-amber" : "badge-amber");
    bodyEl.innerHTML = "";
    if (body) {
      var msg = document.createElement("div");
      msg.textContent = body;
      bodyEl.appendChild(msg);
    }
    if (code) {
      var pre = document.createElement("pre");
      pre.className = "action-pre";
      pre.textContent = code;
      bodyEl.appendChild(pre);
    }
    panel.classList.remove("hidden");
  }
  /* legacy broken function injectCommandToTerminal(command) {
    var frame = $("termFrame");
    if (!frame || !frame.contentWindow) {
      setActionFeedback("warn", "终端未就绪", "终端尚未就绪，无法填入命令。");
      return;
    }
    try {
      var doc = frame.contentWindow.document;
      var input = findTerminalTextarea(doc);
      if (!input) {
        setActionFeedback("warn", "终端未就绪", "终端输入框暂不可用，请先点击一次下方终端。");
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
      setActionFeedback("ok", "命令已填入终端", "按回车即可执行。", command);
    } catch (_err) {
      setActionFeedback("warn", "终端写入失败", "无法直接写入终端，请先点击终端后再试。");
    }
  }
  } */
  /* active injectCommandToTerminal(command) {
    var frame = $("termFrame");
    if (!frame || !frame.contentWindow) {
      setActionFeedback("warn", "终端未就绪", "终端尚未就绪，无法填入命令。");
      return;
    }
    try {
      var doc = frame.contentWindow.document;
      var input = findTerminalTextarea(doc);
      if (!input) {
        setActionFeedback("warn", "终端未就绪", "终端输入框暂不可用，请先点击一次下方终端。");
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
      if ($("actionPanel")) { $("actionPanel").classList.add("hidden"); }
    } catch (_err) {
      setActionFeedback("warn", "终端写入失败", "无法直接写入终端，请先点击终端后再试。");
    }
  }
  } */
  function injectCommandToTerminal(command, submit) {
    var frame = $("termFrame");
    if (!frame || !frame.contentWindow) {
      setActionFeedback("warn", "\u7ec8\u7aef\u672a\u5c31\u7eea", "\u7ec8\u7aef\u5c1a\u672a\u5c31\u7eea\uff0c\u65e0\u6cd5\u586b\u5165\u547d\u4ee4\u3002");
      return;
    }
    try {
      var doc = frame.contentWindow.document;
      var input = findTerminalTextarea(doc);
      if (!input) {
        setActionFeedback("warn", "\u7ec8\u7aef\u672a\u5c31\u7eea", "\u7ec8\u7aef\u8f93\u5165\u6846\u6682\u4e0d\u53ef\u7528\uff0c\u8bf7\u5148\u70b9\u51fb\u4e00\u6b21\u4e0b\u65b9\u7ec8\u7aef\u3002");
        return;
      }
      var payload = String(command || "");
      if (submit && !/\n$/.test(payload)) {
        payload += "\n";
      }
      frame.contentWindow.focus();
      input.focus();
      input.value = payload;
      input.dispatchEvent(new InputEvent("input", {
        bubbles: true,
        cancelable: true,
        data: payload,
        inputType: "insertText"
      }));
      if ($("actionPanel")) { $("actionPanel").classList.add("hidden"); }
    } catch (_err) {
      setActionFeedback("warn", "\u7ec8\u7aef\u5199\u5165\u5931\u8d25", "\u65e0\u6cd5\u76f4\u63a5\u5199\u5165\u7ec8\u7aef\uff0c\u8bf7\u5148\u70b9\u51fb\u7ec8\u7aef\u540e\u518d\u8bd5\u3002");
    }
  }
  function copyText(text) {
    var value = String(text || "");
    if (!value) {
      return Promise.reject(new Error("empty"));
    }
    if (navigator.clipboard && window.isSecureContext) {
      return navigator.clipboard.writeText(value);
    }
    return new Promise(function (resolve, reject) {
      var ta = document.createElement("textarea");
      ta.value = value;
      ta.setAttribute("readonly", "");
      ta.style.position = "fixed";
      ta.style.top = "-1000px";
      ta.style.left = "-1000px";
      ta.style.opacity = "0";
      document.body.appendChild(ta);
      ta.focus();
      ta.select();
      ta.setSelectionRange(0, ta.value.length);
      try {
        if (document.execCommand("copy")) {
          document.body.removeChild(ta);
          resolve();
          return;
        }
      } catch (_err) {
      }
      document.body.removeChild(ta);
      reject(new Error("copy_failed"));
    });
  }
  function flashButtonText(id, successText, idleText) {
    var el = $(id);
    if (!el) { return; }
    el.textContent = successText;
    setTimeout(function () { el.textContent = idleText; }, 1500);
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
  /* legacy broken runtime block: function setHealthState(ok, message) {
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
  var gwUrlIsHttps = /^https:\/\//i.test(GW_URL || "");
  if (isSecure) {
    $("diagSecure").textContent = "安全";
    $("diagSecure").className = "diag-ok";
  } else if (ACCESS_MODE === "lan_https" && gwUrlIsHttps) {
    $("diagSecure").textContent = "入口页非安全，原生界面安全";
    $("diagSecure").className = "diag-warn";
    $("diagSecure").title = "当前 HA Ingress 页面本身不是安全上下文，但通过上方“打开原生 Gateway 界面”进入的 HTTPS 控制界面是安全的。";
  } else {
    $("diagSecure").textContent = "不安全";
    $("diagSecure").className = "diag-err";
  }

  var modeColors = {
    lan_https: "badge-green",
    tailnet_https: "badge-green",
    lan_reverse_proxy: "badge-blue",
    local_only: "badge-gray",
    custom: "badge-amber"
  };
  $("modeBadge").className = "badge " + (modeColors[ACCESS_MODE] || "badge-gray");
  $("modeBadge").textContent = ACCESS_MODE_LABELS[ACCESS_MODE] || ACCESS_MODE;
  $("modeBadge").title = ACCESS_MODE;
  $("diagAccess").textContent = ACCESS_MODE_LABELS[ACCESS_MODE] || ACCESS_MODE;
  $("diagAccess").title = ACCESS_MODE;
  $("gatewayModeText").textContent = GATEWAY_MODE_LABELS[GATEWAY_MODE] || GATEWAY_MODE;
  $("gatewayModeText").title = GATEWAY_MODE;

  function normalizePidRow() {
    var kept = false;
    var rows = document.querySelectorAll(".kv");
    rows.forEach(function (row) {
      var badges = row.querySelectorAll(".badge");
      if (badges.length !== 4) { return; }
      if (!/^nginx\s+/i.test(badges[1].textContent.trim())) { return; }
      if (!/^ttyd\s+/i.test(badges[2].textContent.trim())) { return; }

      var key = row.querySelector(".kv-key");
      if (key) { key.textContent = "PID"; }

      var gwPid = badges[0].textContent.trim().split(/\s+/).pop();
      var nginxPid = badges[1].textContent.trim().split(/\s+/).pop();
      var ttydPid = badges[2].textContent.trim().split(/\s+/).pop();
      var actionPid = badges[3].textContent.trim().split(/\s+/).pop();

      badges[0].textContent = "Gateway " + gwPid;
      badges[1].textContent = "nginx " + nginxPid;
      badges[2].textContent = "ttyd " + ttydPid;
      badges[3].textContent = "Action " + actionPid;
      if (!kept) {
        kept = true;
        row.classList.remove("hidden");
      } else {
        row.classList.add("hidden");
      }
    });
  }

  function attachPidRowTemplate() {
    return;
  }

  function normalizeLocalCopy() {
    var guideCards = document.querySelectorAll(".guide-card");
    if (guideCards[0]) {
      guideCards[0].innerHTML =
        '<h3>配置页负责</h3>' +
        '<ul>' +
        '<li><code>Home Assistant Token</code>、MCP、访问模式、端口等 add-on 参数</li>' +
        '<li><code>Brave Search</code>、<code>Gemini Memory Search</code> 这类能力开关</li>' +
        '<li>保存并重启 add-on 后自动生效</li>' +
        '</ul>';
    }
    if (guideCards[1]) {
      guideCards[1].innerHTML =
        '<h3>终端里的 <code>openclaw onboard</code></h3>' +
        '<ul>' +
        '<li>登录主模型账号 / OAuth</li>' +
        '<li>选择默认聊天模型、channels、hooks</li>' +
        '<li>更适合首次初始化，不建议每次启动都重复操作</li>' +
        '</ul>';
    }

    var notes = document.querySelectorAll(".mini-note");
    if (notes[0]) {
      notes[0].innerHTML = '建议：配置页负责 add-on 参数，<code>openclaw onboard</code> 负责 OpenClaw 自身初始化。';
    }
    if (notes[1]) {
      notes[1].textContent = '这里只显示当前已启用的能力状态；未启用的 MCP / Web Search / Memory Search 会自动隐藏。';
    }

    var subtitles = document.querySelectorAll(".section-subtitle");
    if (subtitles[0]) { subtitles[0].textContent = '配对与初始化'; }
    if (subtitles[1]) { subtitles[1].textContent = '诊断与维护'; }
    if (subtitles[2]) { subtitles[2].textContent = '备份与恢复'; }

    var backupHint = document.querySelector('.hero-sub[style*="margin-top:6px"]');
    if (backupHint) {
      backupHint.innerHTML = '共享备份目录：<code>/share/openclaw-backup/latest</code>';
    }
  }

  attachPidRowTemplate();
  normalizePidRow();
  normalizeLocalCopy();

  if (ACCESS_MODE === "lan_https" && HTTPS_PORT) {
    var certBtn = $("certBtn");
    certBtn.href = "https://" + location.hostname + ":" + HTTPS_PORT + "/cert/ca.crt";
    certBtn.classList.remove("hidden");
  }

  var mcpEl = $("diagMcp");
  if (mcpEl) {
    var st = mcpEl.textContent.trim().toLowerCase();
    mcpEl.dataset.rawStatus = st;
    if (st === "registered" || st === "enabled") {
      mcpEl.textContent = "已注册";
      mcpEl.className = "diag-ok";
    } else if (st === "configured") {
      mcpEl.textContent = "MCP configured";
      mcpEl.className = "diag-warn";
      mcpEl.title = "mcporter config exists, but startup verification has not completed yet.";
    } else if (st === "disabled") {
      mcpEl.textContent = "已关闭";
      mcpEl.className = "diag-muted";
    } else if (st === "needs-token") {
      mcpEl.textContent = "缺少令牌";
      mcpEl.className = "diag-warn";
      mcpEl.title = "已启用 auto_configure_mcp，但还没有填写 homeassistant_token。";
    } else if (st === "mcporter-missing") {
      mcpEl.textContent = "缺少 mcporter";
      mcpEl.className = "diag-warn";
      mcpEl.title = "当前镜像里没有 mcporter，因此无法自动注册 Home Assistant MCP。";
    } else if (!st) {
      mcpEl.textContent = "未配置";
      mcpEl.className = "diag-muted";
    }
  }

  if (mcpEl) {
    var mcpRow = mcpEl.closest(".diag-row");
    var mcpState = (mcpEl.dataset.rawStatus || "").trim().toLowerCase();
    if (mcpRow) {
      if (mcpState === "disabled" || !mcpState) {
        mcpRow.classList.add("hidden");
      } else {
        mcpRow.classList.remove("hidden");
      }
    }
  }

  var webRow = $("diagWebRow");
  var webEl = $("diagWeb");
  if (webRow && webEl) {
    if (WEB_SEARCH_ENABLED) {
      webEl.textContent = WEB_SEARCH_PROVIDER || "已启用";
      webEl.className = "diag-ok";
      webEl.title = WEB_SEARCH_PROVIDER ? "当前启用的 web_search provider" : "Web search 已启用";
      webRow.classList.remove("hidden");
    } else {
      webRow.classList.add("hidden");
    }
  }

  var memoryRow = $("diagMemoryRow");
  var memoryEl = $("diagMemory");
  if (memoryRow && memoryEl) {
    if (MEMORY_SEARCH_ENABLED) {
      var parts = [];
      if (MEMORY_SEARCH_PROVIDER) { parts.push(MEMORY_SEARCH_PROVIDER); }
      if (MEMORY_SEARCH_MODEL) { parts.push(MEMORY_SEARCH_MODEL); }
      memoryEl.textContent = parts.length ? parts.join(" / ") : "已启用";
      memoryEl.className = "diag-ok";
      memoryEl.title = parts.length ? "当前启用的 memory search provider / model" : "Memory search 已启用";
      memoryRow.classList.remove("hidden");
    } else {
      memoryRow.classList.add("hidden");
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
          setActionFeedback("warn", "未能自动附带令牌", "已退回普通打开方式。如果控制界面要求令牌，可先点击“显示”或“read token”。");
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
        setTextAndSelect("tokenDisplay", "可在终端里用 jq 读取。");
        setActionFeedback("warn", "读取令牌失败", "可以使用下方快捷命令“read token”，或在终端中手动读取。");
      });
  });

  $("tokenCopyBtn") && $("tokenCopyBtn").addEventListener("click", function () {
    if (!tokenValue) { return; }
    copyText(tokenValue)
      .then(function () {
        flashButtonText("tokenCopyBtn", "已复制", "复制");
      })
      .catch(function () {
        setTextAndSelect("tokenDisplay", tokenValue);
        setActionFeedback("warn", "令牌复制失败", "已为你选中令牌文本，请手动复制。");
      });
  });

  $("gatewayCopyBtn").addEventListener("click", function () {
    if (!GW_URL) { return; }
    copyText(GW_URL)
      .then(function () {
        flashButtonText("gatewayCopyBtn", "已复制", "复制");
      })
      .catch(function () {
        setTextAndSelect("gatewayUrlText", GW_URL);
        setActionFeedback("warn", "地址复制失败", "已为你选中网关地址，请手动复制。");
      });
  });

  $("gatewayUrlText").addEventListener("click", function () {
    if (!GW_URL) { return; }
    copyText(GW_URL).then(function () {
      flashButtonText("gatewayCopyBtn", "已复制", "复制");
    }).catch(function () {
      setTextAndSelect("gatewayUrlText", GW_URL);
      setActionFeedback("warn", "地址已选中", "当前环境不支持直接复制，请手动复制已选中的地址。");
    });
  });

  $("tokenDisplay").addEventListener("click", function () {
    if (!tokenValue) {
      selectText($("tokenDisplay"));
      return;
    }
    copyText(tokenValue).then(function () {
      flashButtonText("tokenCopyBtn", "已复制", "复制");
    }).catch(function () {
      setTextAndSelect("tokenDisplay", tokenValue);
      setActionFeedback("warn", "令牌已选中", "当前环境不支持直接复制，请手动复制已选中的令牌。");
    });
  });

  function runGatewayAction(action, label) {
    setActionFeedback("warn", label + "中", "请稍候，正在调用本地动作服务。");
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
          setActionFeedback("err", label + "失败", "请检查下方输出。", output || "无输出");
          return;
        }
        setActionFeedback("ok", label + "完成", "命令执行成功。", output || "");
        if (action === "restart") {
          setTimeout(checkGateway, 1500);
        }
      })
      .catch(function () {
        setActionFeedback("err", label + "失败", "无法访问本地动作服务。");
      });
  }

  $("gatewayStatusBtn").addEventListener("click", function () {
    runGatewayAction("status", "查看网关状态");
  });

  $("gatewayRestartBtn").addEventListener("click", function () {
    runGatewayAction("restart", "重启网关");
  });

  $("checkUpdateBtn").addEventListener("click", function () {
    setActionFeedback("warn", "检查 npm 版本中", "正在连接 npm 仓库。");
    fetch("https://registry.npmjs.org/openclaw/latest", { cache: "no-cache" })
      .then(function (r) {
        if (!r.ok) { throw new Error("npm"); }
        return r.json();
      })
      .then(function (d) {
        if (d.version && d.version !== OC_VER) {
          setActionFeedback("warn", "发现新版本", "npm 最新版本为 " + d.version + "，当前内置版本为 " + OC_VER + "。");
        } else {
          setActionFeedback("ok", "版本已是最新", "当前内置版本已是最新：" + OC_VER + "。");
        }
      })
      .catch(function () {
        setActionFeedback("err", "检查失败", "当前无法连接到 npm。");
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
  } */

  /* active runtime block: function setHealthState(ok, message) {
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
  var gwUrlIsHttps = /^https:\/\//i.test(GW_URL || "");
  if (isSecure) {
    $("diagSecure").textContent = "安全";
    $("diagSecure").className = "diag-ok";
  } else if (ACCESS_MODE === "lan_https" && gwUrlIsHttps) {
    $("diagSecure").textContent = "入口页非安全，原生界面安全";
    $("diagSecure").className = "diag-warn";
    $("diagSecure").title = "当前 HA Ingress 页面本身不是安全上下文，但通过上方“打开原生 Gateway 界面”进入的 HTTPS 控制界面是安全的。";
  } else {
    $("diagSecure").textContent = "不安全";
    $("diagSecure").className = "diag-err";
  }

  var modeColors = {
    lan_https: "badge-green",
    tailnet_https: "badge-green",
    lan_reverse_proxy: "badge-blue",
    local_only: "badge-gray",
    custom: "badge-amber"
  };
  $("modeBadge").className = "badge " + (modeColors[ACCESS_MODE] || "badge-gray");
  $("modeBadge").textContent = ACCESS_MODE_LABELS[ACCESS_MODE] || ACCESS_MODE;
  $("modeBadge").title = ACCESS_MODE;
  $("diagAccess").textContent = ACCESS_MODE_LABELS[ACCESS_MODE] || ACCESS_MODE;
  $("diagAccess").title = ACCESS_MODE;
  $("gatewayModeText").textContent = GATEWAY_MODE_LABELS[GATEWAY_MODE] || GATEWAY_MODE;
  $("gatewayModeText").title = GATEWAY_MODE;

  function normalizePidRow() {
    var kept = false;
    var rows = document.querySelectorAll(".kv");
    rows.forEach(function (row) {
      var badges = row.querySelectorAll(".badge");
      if (badges.length !== 4) { return; }
      if (!/^nginx\s+/i.test(badges[1].textContent.trim())) { return; }
      if (!/^ttyd\s+/i.test(badges[2].textContent.trim())) { return; }

      var key = row.querySelector(".kv-key");
      if (key) { key.textContent = "PID"; }

      var gwPid = badges[0].textContent.trim().split(/\s+/).pop();
      var nginxPid = badges[1].textContent.trim().split(/\s+/).pop();
      var ttydPid = badges[2].textContent.trim().split(/\s+/).pop();
      var actionPid = badges[3].textContent.trim().split(/\s+/).pop();

      badges[0].textContent = "Gateway " + gwPid;
      badges[1].textContent = "nginx " + nginxPid;
      badges[2].textContent = "ttyd " + ttydPid;
      badges[3].textContent = "Action " + actionPid;
      if (!kept) {
        kept = true;
        row.classList.remove("hidden");
      } else {
        row.classList.add("hidden");
      }
    });
  }

  function attachPidRowTemplate() {
    return;
  }

  function normalizeLocalCopy() {
    var guideCards = document.querySelectorAll(".guide-card");
    if (guideCards[0]) {
      guideCards[0].innerHTML =
        '<h3>配置页负责</h3>' +
        '<ul>' +
        '<li><code>Home Assistant Token</code>、MCP、访问模式、端口等 add-on 参数</li>' +
        '<li><code>Brave Search</code>、<code>Gemini Memory Search</code> 这类能力开关</li>' +
        '<li>保存并重启 add-on 后自动生效</li>' +
        '</ul>';
    }
    if (guideCards[1]) {
      guideCards[1].innerHTML =
        '<h3>终端里的 <code>openclaw onboard</code></h3>' +
        '<ul>' +
        '<li>登录主模型账号 / OAuth</li>' +
        '<li>选择默认聊天模型、channels、hooks</li>' +
        '<li>更适合首次初始化，不建议每次启动都重复操作</li>' +
        '</ul>';
    }

    var notes = document.querySelectorAll(".mini-note");
    if (notes[0]) {
      notes[0].innerHTML = '建议：配置页负责 add-on 参数，<code>openclaw onboard</code> 负责 OpenClaw 自身初始化。';
    }
    if (notes[1]) {
      notes[1].textContent = '这里只显示当前已启用的能力状态；未启用的 MCP / Web Search / Memory Search 会自动隐藏。';
    }

    var subtitles = document.querySelectorAll(".section-subtitle");
    if (subtitles[0]) { subtitles[0].textContent = '配对与初始化'; }
    if (subtitles[1]) { subtitles[1].textContent = '诊断与维护'; }
    if (subtitles[2]) { subtitles[2].textContent = '备份与恢复'; }

    var backupHint = document.querySelector('.hero-sub[style*="margin-top:6px"]');
    if (backupHint) {
      backupHint.innerHTML = '共享备份目录：<code>/share/openclaw-backup/latest</code>';
    }
  }

  attachPidRowTemplate();
  normalizePidRow();
  normalizeLocalCopy();

  if (ACCESS_MODE === "lan_https" && HTTPS_PORT) {
    var certBtn = $("certBtn");
    certBtn.href = "https://" + location.hostname + ":" + HTTPS_PORT + "/cert/ca.crt";
    certBtn.classList.remove("hidden");
  }

  var mcpEl = $("diagMcp");
  if (mcpEl) {
    var st = mcpEl.textContent.trim().toLowerCase();
    mcpEl.dataset.rawStatus = st;
    if (st === "registered" || st === "enabled") {
      mcpEl.textContent = "已注册";
      mcpEl.className = "diag-ok";
    } else if (st === "configured") {
      mcpEl.textContent = "已配置";
      mcpEl.className = "diag-warn";
      mcpEl.title = "mcporter 配置已经存在，但启动后的验证还没完成。";
    } else if (st === "disabled") {
      mcpEl.textContent = "已关闭";
      mcpEl.className = "diag-muted";
    } else if (st === "needs-token") {
      mcpEl.textContent = "缺少令牌";
      mcpEl.className = "diag-warn";
      mcpEl.title = "已经启用 auto_configure_mcp，但还没有填写 homeassistant_token。";
    } else if (st === "mcporter-missing") {
      mcpEl.textContent = "缺少 mcporter";
      mcpEl.className = "diag-warn";
      mcpEl.title = "当前镜像里没有 mcporter，因此无法自动注册 Home Assistant MCP。";
    } else if (!st) {
      mcpEl.textContent = "未配置";
      mcpEl.className = "diag-muted";
    }
  }

  if (mcpEl) {
    var mcpRow = mcpEl.closest(".diag-row");
    var mcpState = (mcpEl.dataset.rawStatus || "").trim().toLowerCase();
    if (mcpRow) {
      if (mcpState === "disabled" || !mcpState) {
        mcpRow.classList.add("hidden");
      } else {
        mcpRow.classList.remove("hidden");
      }
    }
  }

  var webRow = $("diagWebRow");
  var webEl = $("diagWeb");
  if (webRow && webEl) {
    if (WEB_SEARCH_ENABLED) {
      webEl.textContent = WEB_SEARCH_PROVIDER || "已启用";
      webEl.className = "diag-ok";
      webEl.title = WEB_SEARCH_PROVIDER ? "当前启用的 web_search provider" : "Web Search 已启用";
      webRow.classList.remove("hidden");
    } else {
      webRow.classList.add("hidden");
    }
  }

  var memoryRow = $("diagMemoryRow");
  var memoryEl = $("diagMemory");
  if (memoryRow && memoryEl) {
    if (MEMORY_SEARCH_ENABLED) {
      var parts = [];
      if (MEMORY_SEARCH_PROVIDER) { parts.push(MEMORY_SEARCH_PROVIDER); }
      if (MEMORY_SEARCH_MODEL) { parts.push(MEMORY_SEARCH_MODEL); }
      memoryEl.textContent = parts.length ? parts.join(" / ") : "已启用";
      memoryEl.className = "diag-ok";
      memoryEl.title = parts.length ? "当前启用的 memory search provider / model" : "Memory Search 已启用";
      memoryRow.classList.remove("hidden");
    } else {
      memoryRow.classList.add("hidden");
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
          setActionFeedback("warn", "未能自动附带令牌", "已退回普通打开方式。如果控制界面要求令牌，可先点击“显示”或“read token”。");
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
        setTextAndSelect("tokenDisplay", "可在终端里用 jq 读取。");
        setActionFeedback("warn", "读取令牌失败", "可以使用下方快捷命令“read token”，或在终端中手动读取。");
      });
  });

  $("tokenCopyBtn") && $("tokenCopyBtn").addEventListener("click", function () {
    if (!tokenValue) { return; }
    copyText(tokenValue)
      .then(function () {
        flashButtonText("tokenCopyBtn", "已复制", "复制");
      })
      .catch(function () {
        setTextAndSelect("tokenDisplay", tokenValue);
        setActionFeedback("warn", "令牌复制失败", "已为你选中令牌文本，请手动复制。");
      });
  });

  $("gatewayCopyBtn").addEventListener("click", function () {
    if (!GW_URL) { return; }
    copyText(GW_URL)
      .then(function () {
        flashButtonText("gatewayCopyBtn", "已复制", "复制");
      })
      .catch(function () {
        setTextAndSelect("gatewayUrlText", GW_URL);
        setActionFeedback("warn", "地址复制失败", "已为你选中网关地址，请手动复制。");
      });
  });

  $("gatewayUrlText").addEventListener("click", function () {
    if (!GW_URL) { return; }
    copyText(GW_URL).then(function () {
      flashButtonText("gatewayCopyBtn", "已复制", "复制");
    }).catch(function () {
      setTextAndSelect("gatewayUrlText", GW_URL);
      setActionFeedback("warn", "地址已选中", "当前环境不支持直接复制，请手动复制已选中的地址。");
    });
  });

  $("tokenDisplay").addEventListener("click", function () {
    if (!tokenValue) {
      selectText($("tokenDisplay"));
      return;
    }
    copyText(tokenValue).then(function () {
      flashButtonText("tokenCopyBtn", "已复制", "复制");
    }).catch(function () {
      setTextAndSelect("tokenDisplay", tokenValue);
      setActionFeedback("warn", "令牌已选中", "当前环境不支持直接复制，请手动复制已选中的令牌。");
    });
  });

  function runGatewayAction(action, label) {
    setActionFeedback("warn", label + "中", "请稍候，正在调用本地动作服务。");
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
          setActionFeedback("err", label + "失败", "请检查下方输出。", output || "无输出");
          return;
        }
        setActionFeedback("ok", label + "完成", "命令执行成功。", output || "");
        if (action === "restart") {
          setTimeout(checkGateway, 1500);
        }
      })
      .catch(function () {
        setActionFeedback("err", label + "失败", "无法访问本地动作服务。");
      });
  }

  $("gatewayStatusBtn").addEventListener("click", function () {
    runGatewayAction("status", "查看网关状态");
  });

  $("gatewayRestartBtn").addEventListener("click", function () {
    runGatewayAction("restart", "重启网关");
  });

  $("checkUpdateBtn").addEventListener("click", function () {
    setActionFeedback("warn", "检查 npm 版本中", "正在连接 npm 仓库。");
    fetch("https://registry.npmjs.org/openclaw/latest", { cache: "no-cache" })
      .then(function (r) {
        if (!r.ok) { throw new Error("npm"); }
        return r.json();
      })
      .then(function (d) {
        if (d.version && d.version !== OC_VER) {
          setActionFeedback("warn", "发现新版本", "npm 最新版本为 " + d.version + "，当前内置版本为 " + OC_VER + "。");
        } else {
          setActionFeedback("ok", "版本已是最新", "当前内置版本已是最新：" + OC_VER + "。");
        }
      })
      .catch(function () {
        setActionFeedback("err", "检查失败", "当前无法连接到 npm。");
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
  } */

  function setHealthState(ok, message) {
    var dot = $("statusDot");
    var txt = $("statusText");
    var badges = $("statusBadges");
    if (ok) {
      dot.className = "dot dot-green";
      txt.textContent = message || "\u8fd0\u884c\u4e2d";
      txt.style.color = "var(--green)";
      badges.innerHTML = '<span class="badge badge-green">\u7f51\u5173\u6b63\u5e38</span>';
      $("diagGateway").textContent = "\u6b63\u5e38";
      $("diagGateway").className = "diag-ok";
    } else {
      dot.className = "dot dot-red";
      txt.textContent = message || "\u4e0d\u53ef\u7528";
      txt.style.color = "var(--red)";
      badges.innerHTML = '<span class="badge badge-amber">\u68c0\u67e5\u914d\u7f6e</span>';
      $("diagGateway").textContent = "\u4e0d\u53ef\u7528";
      $("diagGateway").className = "diag-err";
    }
  }

  if (DISK_PCT) {
    var dp = parseInt(DISK_PCT, 10);
    setBar("diskBar", dp);
    if (dp >= 75) {
      $("diskBanner").classList.remove("hidden");
      $("diskBanner").textContent = "\u78c1\u76d8\u5df2\u4f7f\u7528 " + DISK_PCT + "\uff0c\u5269\u4f59\u7a7a\u95f4 " + DISK_AVAIL + "\u3002";
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
  var gwUrlIsHttps = /^https:\/\//i.test(GW_URL || "");
  if (isSecure) {
    $("diagSecure").textContent = "\u5b89\u5168";
    $("diagSecure").className = "diag-ok";
  } else if (ACCESS_MODE === "lan_https" && gwUrlIsHttps) {
    $("diagSecure").textContent = "\u5165\u53e3\u9875\u975e\u5b89\u5168\uff0c\u539f\u751f\u754c\u9762\u5b89\u5168";
    $("diagSecure").className = "diag-warn";
    $("diagSecure").title = "\u5f53\u524d HA Ingress \u9875\u9762\u672c\u8eab\u4e0d\u662f\u5b89\u5168\u4e0a\u4e0b\u6587\uff0c\u4f46\u901a\u8fc7\u4e0a\u65b9\u201c\u6253\u5f00\u539f\u751f Gateway \u754c\u9762\u201d\u8fdb\u5165\u7684 HTTPS \u63a7\u5236\u754c\u9762\u662f\u5b89\u5168\u7684\u3002";
  } else {
    $("diagSecure").textContent = "\u4e0d\u5b89\u5168";
    $("diagSecure").className = "diag-err";
  }

  var modeColors = {
    lan_https: "badge-green",
    tailnet_https: "badge-green",
    lan_reverse_proxy: "badge-blue",
    local_only: "badge-gray",
    custom: "badge-amber"
  };
  $("modeBadge").className = "badge " + (modeColors[ACCESS_MODE] || "badge-gray");
  $("modeBadge").textContent = ACCESS_MODE_LABELS[ACCESS_MODE] || ACCESS_MODE;
  $("modeBadge").title = ACCESS_MODE;
  $("diagAccess").textContent = ACCESS_MODE_LABELS[ACCESS_MODE] || ACCESS_MODE;
  $("diagAccess").title = ACCESS_MODE;
  $("gatewayModeText").textContent = GATEWAY_MODE_LABELS[GATEWAY_MODE] || GATEWAY_MODE;
  $("gatewayModeText").title = GATEWAY_MODE;

  function normalizePidRow() {
    var kept = false;
    var rows = document.querySelectorAll(".kv");
    rows.forEach(function (row) {
      var badges = row.querySelectorAll(".badge");
      if (badges.length !== 4) { return; }
      if (!/^nginx\s+/i.test(badges[1].textContent.trim())) { return; }
      if (!/^ttyd\s+/i.test(badges[2].textContent.trim())) { return; }

      var key = row.querySelector(".kv-key");
      if (key) { key.textContent = "PID"; }

      var gwPid = badges[0].textContent.trim().split(/\s+/).pop();
      var nginxPid = badges[1].textContent.trim().split(/\s+/).pop();
      var ttydPid = badges[2].textContent.trim().split(/\s+/).pop();
      var actionPid = badges[3].textContent.trim().split(/\s+/).pop();

      badges[0].textContent = "Gateway " + gwPid;
      badges[1].textContent = "nginx " + nginxPid;
      badges[2].textContent = "ttyd " + ttydPid;
      badges[3].textContent = "Action " + actionPid;
      if (!kept) {
        kept = true;
        row.classList.remove("hidden");
      } else {
        row.classList.add("hidden");
      }
    });
  }

  normalizePidRow();

  if (ACCESS_MODE === "lan_https" && HTTPS_PORT) {
    var certBtn = $("certBtn");
    if (certBtn) {
      certBtn.href = "https://" + location.hostname + ":" + HTTPS_PORT + "/cert/ca.crt";
      certBtn.classList.remove("hidden");
    }
  }

  var mcpEl = $("diagMcp");
  if (mcpEl) {
    var st = mcpEl.textContent.trim().toLowerCase();
    mcpEl.dataset.rawStatus = st;
    if (st === "registered" || st === "enabled") {
      mcpEl.textContent = "\u5df2\u6ce8\u518c";
      mcpEl.className = "diag-ok";
    } else if (st === "configured") {
      mcpEl.textContent = "\u5df2\u914d\u7f6e";
      mcpEl.className = "diag-warn";
      mcpEl.title = "mcporter \u914d\u7f6e\u5df2\u7ecf\u5b58\u5728\uff0c\u4f46\u542f\u52a8\u540e\u7684\u9a8c\u8bc1\u8fd8\u6ca1\u5b8c\u6210\u3002";
    } else if (st === "disabled") {
      mcpEl.textContent = "\u5df2\u5173\u95ed";
      mcpEl.className = "diag-muted";
    } else if (st === "needs-token") {
      mcpEl.textContent = "\u7f3a\u5c11\u4ee4\u724c";
      mcpEl.className = "diag-warn";
      mcpEl.title = "\u5df2\u7ecf\u542f\u7528 auto_configure_mcp\uff0c\u4f46\u8fd8\u6ca1\u6709\u586b\u5199 homeassistant_token\u3002";
    } else if (st === "mcporter-missing") {
      mcpEl.textContent = "\u7f3a\u5c11 mcporter";
      mcpEl.className = "diag-warn";
      mcpEl.title = "\u5f53\u524d\u955c\u50cf\u91cc\u6ca1\u6709 mcporter\uff0c\u56e0\u6b64\u65e0\u6cd5\u81ea\u52a8\u6ce8\u518c Home Assistant MCP\u3002";
    } else if (!st) {
      mcpEl.textContent = "\u672a\u914d\u7f6e";
      mcpEl.className = "diag-muted";
    }
  }

  if (mcpEl) {
    var mcpRow = mcpEl.closest(".diag-row");
    var mcpState = (mcpEl.dataset.rawStatus || "").trim().toLowerCase();
    if (mcpRow) {
      if (mcpState === "disabled" || !mcpState) {
        mcpRow.classList.add("hidden");
      } else {
        mcpRow.classList.remove("hidden");
      }
    }
  }

  var webRow = $("diagWebRow");
  var webEl = $("diagWeb");
  if (webRow && webEl) {
    if (WEB_SEARCH_ENABLED) {
      webEl.textContent = WEB_SEARCH_PROVIDER || "\u5df2\u542f\u7528";
      webEl.className = "diag-ok";
      webEl.title = WEB_SEARCH_PROVIDER ? "Current web_search provider" : "Web Search enabled";
      webRow.classList.remove("hidden");
    } else {
      webRow.classList.add("hidden");
    }
  }

  var memoryRow = $("diagMemoryRow");
  var memoryEl = $("diagMemory");
  if (memoryRow && memoryEl) {
    if (MEMORY_SEARCH_ENABLED) {
      var parts = [];
      if (MEMORY_SEARCH_PROVIDER) { parts.push(MEMORY_SEARCH_PROVIDER); }
      if (MEMORY_SEARCH_MODEL) { parts.push(MEMORY_SEARCH_MODEL); }
      memoryEl.textContent = parts.length ? parts.join(" / ") : "\u5df2\u542f\u7528";
      memoryEl.className = "diag-ok";
      memoryEl.title = parts.length ? "Current memory search provider / model" : "Memory Search enabled";
      memoryRow.classList.remove("hidden");
    } else {
      memoryRow.classList.add("hidden");
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
      setHealthState(false, "Please set gateway_public_url");
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
      setHealthState(true, GATEWAY_MODE === "remote" ? "\u8fdc\u7a0b\u7f51\u5173\u53ef\u8fbe" : "\u8fd0\u884c\u4e2d");
    } catch (_err) {
      setHealthState(false, GATEWAY_MODE === "remote" ? "\u8fdc\u7a0b\u7f51\u5173\u4e0d\u53ef\u8fbe" : "\u4e0d\u53ef\u7528");
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
          setActionFeedback("warn", "\u672a\u80fd\u81ea\u52a8\u9644\u5e26\u4ee4\u724c", "\u5df2\u9000\u56de\u666e\u901a\u6253\u5f00\u65b9\u5f0f\u3002\u5982\u679c\u63a7\u5236\u754c\u9762\u8981\u6c42\u4ee4\u724c\uff0c\u53ef\u5148\u70b9\u51fb\u201c\u663e\u793a\u201d\u6216\u201cread token\u201d\u3002");
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
        setTextAndSelect("tokenDisplay", "Use jq in terminal to read the token.");
        setActionFeedback("warn", "\u8bfb\u53d6\u4ee4\u724c\u5931\u8d25", "\u53ef\u4ee5\u4f7f\u7528\u4e0b\u65b9\u5feb\u6377\u547d\u4ee4\u201cread token\u201d\uff0c\u6216\u5728\u7ec8\u7aef\u4e2d\u624b\u52a8\u8bfb\u53d6\u3002");
      });
  });

  $("tokenCopyBtn") && $("tokenCopyBtn").addEventListener("click", function () {
    if (!tokenValue) { return; }
    copyText(tokenValue)
      .then(function () {
        flashButtonText("tokenCopyBtn", "\u5df2\u590d\u5236", "\u590d\u5236");
      })
      .catch(function () {
        setTextAndSelect("tokenDisplay", tokenValue);
        setActionFeedback("warn", "\u4ee4\u724c\u590d\u5236\u5931\u8d25", "\u5df2\u4e3a\u4f60\u9009\u4e2d\u4ee4\u724c\u6587\u672c\uff0c\u8bf7\u624b\u52a8\u590d\u5236\u3002");
      });
  });

  $("gatewayCopyBtn").addEventListener("click", function () {
    if (!GW_URL) { return; }
    copyText(GW_URL)
      .then(function () {
        flashButtonText("gatewayCopyBtn", "\u5df2\u590d\u5236", "\u590d\u5236");
      })
      .catch(function () {
        setTextAndSelect("gatewayUrlText", GW_URL);
        setActionFeedback("warn", "\u5730\u5740\u590d\u5236\u5931\u8d25", "\u5df2\u4e3a\u4f60\u9009\u4e2d\u7f51\u5173\u5730\u5740\uff0c\u8bf7\u624b\u52a8\u590d\u5236\u3002");
      });
  });

  $("gatewayUrlText").addEventListener("click", function () {
    if (!GW_URL) { return; }
    copyText(GW_URL).then(function () {
      flashButtonText("gatewayCopyBtn", "\u5df2\u590d\u5236", "\u590d\u5236");
    }).catch(function () {
      setTextAndSelect("gatewayUrlText", GW_URL);
      setActionFeedback("warn", "\u5730\u5740\u5df2\u9009\u4e2d", "\u5f53\u524d\u73af\u5883\u4e0d\u652f\u6301\u76f4\u63a5\u590d\u5236\uff0c\u8bf7\u624b\u52a8\u590d\u5236\u5df2\u9009\u4e2d\u7684\u5730\u5740\u3002");
    });
  });

  $("tokenDisplay").addEventListener("click", function () {
    if (!tokenValue) {
      selectText($("tokenDisplay"));
      return;
    }
    copyText(tokenValue).then(function () {
      flashButtonText("tokenCopyBtn", "\u5df2\u590d\u5236", "\u590d\u5236");
    }).catch(function () {
      setTextAndSelect("tokenDisplay", tokenValue);
      setActionFeedback("warn", "\u4ee4\u724c\u5df2\u9009\u4e2d", "\u5f53\u524d\u73af\u5883\u4e0d\u652f\u6301\u76f4\u63a5\u590d\u5236\uff0c\u8bf7\u624b\u52a8\u590d\u5236\u5df2\u9009\u4e2d\u7684\u4ee4\u724c\u3002");
    });
  });

  $("gatewayStatusBtn").addEventListener("click", function () {
    injectCommandToTerminal("openclaw gateway status --deep", true);
  });

  $("gatewayRestartBtn").addEventListener("click", function () {
    injectCommandToTerminal("openclaw gateway restart", true);
  });

  $("checkUpdateBtn").addEventListener("click", function () {
    injectCommandToTerminal("curl -fsSL https://registry.npmjs.org/openclaw/latest | jq -r '\"npm latest: \" + .version'", true);
  });

  Array.prototype.forEach.call(document.querySelectorAll("[data-term-cmd]"), function (btn) {
    btn.addEventListener("click", function () {
      injectCommandToTerminal(btn.getAttribute("data-term-cmd") || "");
    });
  });

  var wizard = $("wizardCard");
  if (ACCESS_MODE === "lan_https") {
    wizard.className = "banner banner-ok";
    wizard.textContent = "\u5185\u7f6e HTTPS \u4ee3\u7406\u5df2\u542f\u7528\u3002\u5982\u679c\u5e0c\u671b\u624b\u673a\u6216\u5e73\u677f\u6d4f\u89c8\u5668\u4fe1\u4efb\u672c\u5730\u8bc1\u4e66\uff0c\u8bf7\u5b89\u88c5 CA \u8bc1\u4e66\u3002";
  } else if (ACCESS_MODE === "local_only") {
    wizard.className = "banner banner-info";
    wizard.textContent = "Gateway \u5f53\u524d\u53ea\u7ed1\u5b9a\u5728\u672c\u673a\u56de\u73af\u5730\u5740\u3002\u5982\u679c\u9700\u8981\u5c40\u57df\u7f51\u8bbf\u95ee\uff0c\u8bf7\u4f7f\u7528 lan_https \u6216\u53cd\u5411\u4ee3\u7406\u3002";
  } else if (GATEWAY_MODE === "remote") {
    wizard.className = "banner banner-info";
    wizard.textContent = "\u8fd9\u4e2a\u63d2\u4ef6\u5f53\u524d\u8fde\u63a5\u7684\u662f\u8fdc\u7a0b\u7f51\u5173\u3002\u8bf7\u786e\u8ba4 gateway_public_url \u6307\u5411\u771f\u5b9e\u7684\u8fdc\u7a0b\u63a7\u5236\u754c\u9762\u3002";
  }
})();
</script>
</body>
</html>
