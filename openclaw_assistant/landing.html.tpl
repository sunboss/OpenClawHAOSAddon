<!doctype html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>OpenClaw HAOS 鎻掍欢</title>
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
    .page { max-width: 1180px; margin: 0 auto; display: flex; flex-direction: column; gap: 14px; }
    .dashboard-grid {
      display: grid;
      grid-template-columns: minmax(0, 1.18fr) minmax(340px, 0.82fr);
      gap: 14px;
      align-items: start;
    }
    .main-column,
    .side-column {
      display: flex;
      flex-direction: column;
      gap: 14px;
      min-width: 0;
    }
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
    .card-compact {
      padding-top: 14px;
      padding-bottom: 14px;
    }
    .card-sticky {
      position: sticky;
      top: 12px;
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
    .term-wrap {
      position: relative;
      border: 1px solid var(--border);
      border-radius: 16px;
      overflow: hidden;
      height: 55vh;
      min-height: 320px;
      margin-top: 2px;
      background:
        radial-gradient(circle at top left, rgba(37, 99, 235, 0.08), transparent 30%),
        linear-gradient(180deg, #0f172a 0%, #172033 100%);
      box-shadow: inset 0 1px 0 rgba(255,255,255,0.06);
    }
    .term-wrap iframe { width: 100%; height: 100%; border: 0; background: #000; }
    .term-placeholder {
      position: absolute;
      inset: 0;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      gap: 10px;
      padding: 20px;
      text-align: center;
      color: #dbeafe;
      background: linear-gradient(180deg, rgba(15, 23, 42, 0.92), rgba(23, 32, 51, 0.94));
    }
    .term-placeholder strong { font-size: 17px; letter-spacing: -0.02em; }
    .term-placeholder span { font-size: 13px; color: rgba(219, 234, 254, 0.78); max-width: 420px; }
    .term-chip {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      padding: 8px 14px;
      border-radius: 999px;
      border: 1px solid rgba(167, 199, 255, 0.42);
      background: rgba(255,255,255,0.08);
      color: #fff;
      font-weight: 700;
      cursor: pointer;
      transition: transform .18s ease, background .18s ease, border-color .18s ease;
    }
    .term-chip:hover {
      transform: translateY(-1px);
      background: rgba(255,255,255,0.14);
      border-color: rgba(167, 199, 255, 0.62);
    }
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
      .dashboard-grid { grid-template-columns: 1fr; }
      .metrics { grid-template-columns: 1fr; }
      .guide-grid { grid-template-columns: 1fr; }
      .kv { align-items: flex-start; flex-direction: column; }
      .kv-val { justify-content: flex-start; }
      .metric-value { font-size: 30px; }
      .btn { width: 100%; justify-content: center; }
      .card-sticky { position: static; }
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
      <h2>OpenClaw HAOS 鎻掍欢</h2>
      <div class="sub">Home Assistant 鎻掍欢 | 鐗堟湰 __ADDON_VERSION__</div>
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

  <div class="dashboard-grid">
    <div class="main-column">

  <div class="card card-compact">
    <div class="card-title">鏈嶅姟鐘舵€?/div>
    <div class="status-row">
      <div class="status-left">
        <div class="dot dot-amber" id="statusDot"></div>
        <span class="status-text" id="statusText">妫€鏌ヤ腑...</span>
      </div>
      <div class="status-badges" id="statusBadges"></div>
    </div>
    <div class="metrics">
      <div class="metric">
        <div class="metric-label">纾佺洏</div>
        <div class="metric-value">__DISK_PCT__</div>
        <div class="metric-sub">__DISK_USED__ / __DISK_TOTAL__</div>
        <div class="bar-wrap"><div class="bar" id="diskBar" style="width:0%"></div></div>
      </div>
      <div class="metric">
        <div class="metric-label">鍐呭瓨</div>
        <div class="metric-value">__MEM_PCT__</div>
        <div class="metric-sub">__MEM_USED__ / __MEM_TOTAL__</div>
        <div class="bar-wrap"><div class="bar" id="memBar" style="width:0%"></div></div>
      </div>
      <div class="metric">
        <div class="metric-label">CPU</div>
        <div class="metric-value">__CPU_PCT__%</div>
        <div class="metric-sub">1 鍒嗛挓璐熻浇鍙傝€?/div>
        <div class="bar-wrap"><div class="bar" id="cpuBar" style="width:0%"></div></div>
      </div>
    </div>
  </div>

  <div class="banner banner-err hidden" id="diskBanner">
    纾佺洏绌洪棿鍋忎綆銆傚彲鍦ㄧ粓绔腑杩愯 <code>oc-cleanup</code>锛屾垨鍦?HA 涓绘満 Shell 閲屾竻鐞?Docker 闀滃儚銆?  </div>

  <div class="banner banner-warn hidden" id="migrationBanner">
    <code>access_mode: custom</code> 鍙兘杩橀渶瑕侀澶栫殑瀹夊叏涓婁笅鏂囬厤缃€傚娴忚鍣ㄥ拰鎵嬫満鏉ヨ锛?b>lan_https</b> 鏄渶绠€鍗曠殑鍙楁敮鎸佹柟妗堛€?  </div>

  <div class="card card-compact">
    <div class="card-title">鐗堟湰涓庤闂?/div>
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
        <span class="kv-key">缃戝叧妯″紡</span>
        <span class="kv-val"><span class="badge badge-gray" id="gatewayModeText">__GATEWAY_MODE__</span></span>
      </div>
      <div class="kv">
        <span class="kv-key">閰嶇疆鐩綍</span>
        <span class="kv-val mono">/config/.openclaw</span>
      </div>
      <div class="kv">
        <span class="kv-key">缃戝叧鍦板潃</span>
        <span class="kv-val">
          <span class="mono mono-copyable" id="gatewayUrlText" title="鐐瑰嚮澶嶅埗">__GATEWAY_PUBLIC_URL__</span>
          <button class="copy-btn" id="gatewayCopyBtn">澶嶅埗</button>
        </span>
      </div>
      <div class="kv" id="tokenRow">
        <span class="kv-key">缃戝叧浠ょ墝</span>
        <span class="kv-val">
          <span class="mono mono-copyable" id="tokenDisplay" title="鐐瑰嚮澶嶅埗">宸查殣钘?/span>
          <button class="copy-btn" id="tokenRevealBtn">鏄剧ず</button>
          <button class="copy-btn hidden" id="tokenCopyBtn">澶嶅埗</button>
        </span>
      </div>
      <div class="kv">
        <span class="kv-key">绔彛</span>
        <span class="kv-val">
          <span class="badge badge-blue">缃戝叧 __GATEWAY_PORT__</span>
          <span class="badge badge-gray">Ingress 48099</span>
          <span class="badge badge-gray">缁堢 __TERMINAL_PORT__</span>
        </span>
      </div>
      <div class="kv">
        <span class="kv-key">杩涚▼ PID</span>
        <span class="kv-val">
          <span class="badge badge-blue">缃戝叧 __GW_PID__</span>
          <span class="badge badge-gray">nginx __NGINX_PID__</span>
          <span class="badge badge-gray">ttyd __TTYD_PID__</span>
          <span class="badge badge-gray">鍔ㄤ綔 __ACTION_PID__</span>
        </span>
      </div>
    </div>
  </div>

  <div class="card card-compact">
    <div class="hero">
      <div class="hero-title">HAOS 鎺у埗涓績</div>
      <div class="hero-sub">
        杩欎釜椤甸潰鏄?OpenClaw 鍦?Home Assistant 閲岀殑缁熶竴鍏ュ彛銆備綘鍙互鍦ㄦ柊鏍囩椤垫墦寮€鍘熺敓 Gateway 鎺у埗鐣岄潰锛屼篃鍙互鐣欏湪杩欓噷鏌ョ湅鍋ュ悍鐘舵€併€佷护鐗屻€佺粓绔拰璁块棶璇婃柇銆?      </div>
      <div class="hero-tip">
        濡傛灉鎵撳紑鍘熺敓 Gateway 鐣岄潰鍚庝粛鎻愮ず璁惧绛惧悕杩囨湡锛岃鍏堟竻闄よ绔欑偣缂撳瓨鎴栨敼鐢ㄦ棤鐥曠獥鍙ｏ紝鍐嶉噸鏂版墦寮€銆?      </div>
      <div class="guide-grid">
        <div class="guide-card">
          <h3>鍦ㄨ繖閲岄厤缃?/h3>
          <ul>
            <li><code>Home Assistant Token</code>銆丮CP銆佽闂ā寮忋€佺鍙ｇ瓑 add-on 鍙傛暟</li>
            <li><code>Brave Search</code>銆?code>Gemini Memory Search</code> 杩欑被鑳藉姏寮€鍏?/li>
            <li>淇濆瓨骞堕噸鍚?add-on 鍚庤嚜鍔ㄧ敓鏁?/li>
          </ul>
        </div>
        <div class="guide-card">
          <h3>鍦ㄧ粓绔繍琛?<code>openclaw onboard</code></h3>
          <ul>
            <li>鐧诲綍涓绘ā鍨嬭处鍙?/ OAuth</li>
            <li>閫夋嫨榛樿鑱婂ぉ妯″瀷銆乧hannels銆乭ooks</li>
            <li>鏇撮€傚悎棣栨鍒濆鍖栵紝涓嶅缓璁瘡娆″惎鍔ㄩ兘閲嶅鎿嶄綔</li>
          </ul>
        </div>
      </div>
      <div class="mini-note">寤鸿锛氶厤缃〉璐熻矗 add-on 鍙傛暟锛?code>openclaw onboard</code> 璐熻矗 OpenClaw 鑷韩鍒濆鍖栥€?/div>
    </div>
    <hr class="divider">
    <div class="card-title">鎿嶄綔</div>
    <div class="btn-grid">
      <a class="btn btn-primary" id="gwBtn" href="__GATEWAY_PUBLIC_URL____GW_PUBLIC_URL_PATH__" target="_blank" rel="noopener noreferrer">鎵撳紑鍘熺敓 Gateway 鐣岄潰</a>
      <a class="btn" href="./terminal/" target="_self">鎵撳紑缁堢</a>
      <a class="btn hidden" id="certBtn" href="" target="_blank" rel="noopener noreferrer">涓嬭浇 CA 璇佷功</a>
      <button class="btn" id="gatewayStatusBtn">鏌ョ湅缃戝叧鐘舵€?/button>
      <button class="btn" id="gatewayRestartBtn">閲嶅惎缃戝叧</button>
      <button class="btn" id="checkUpdateBtn">妫€鏌?npm 鐗堟湰</button>
    </div>
    <hr class="divider">
    <div class="card-title">缁堢蹇嵎鍛戒护</div>
    <div class="section-subtitle">閰嶅涓庡垵濮嬪寲</div>
    <div class="btn-grid">
      <button class="btn" data-term-cmd="openclaw devices list">devices list</button>
      <button class="btn" data-term-cmd="openclaw devices approve --latest">approve --latest</button>
      <button class="btn" data-term-cmd="openclaw onboard">onboard</button>
      <button class="btn" data-term-cmd="openclaw doctor --fix">doctor --fix</button>
    </div>
    <div class="section-subtitle">璇婃柇涓庣淮鎶?/div>
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
    <div class="section-subtitle">澶囦唤涓庢仮澶?/div>
      <div class="btn-grid">
        <button class="btn" data-term-cmd="ls -la /share/openclaw-backup/latest">backup dir</button>
        <button class="btn" data-term-cmd="mkdir -p /share/openclaw-backup/latest && cp -a /config/.openclaw /share/openclaw-backup/latest/ && cp -a /config/.mcporter /share/openclaw-backup/latest/">backup state</button>
      </div>
    <div class="hero-sub" style="margin-top:6px"><code>/share/openclaw-backup/latest</code></div>
    <div class="hero-sub" style="margin-top:8px">
      鐐瑰嚮鍚庝細鎶婂懡浠ゅ～鍏ヤ笅鏂圭粓绔紝涓嶄細鑷姩鎵ц锛涙寜鍥炶溅鍗冲彲杩愯銆?    </div>
    <hr class="divider">
    <div id="actionPanel" class="action-panel hidden">
      <div class="action-head">
        <div class="action-title" id="actionTitle">鎿嶄綔缁撴灉</div>
        <span class="badge badge-gray" id="actionState">鎻愮ず</span>
      </div>
      <div class="action-body" id="actionBody"></div>
    </div>
  </div>

    </div>
    <div class="side-column">

  <div class="card card-compact">
    <div class="card-title">蹇€熻瘖鏂?/div>
    <div class="diag-row">
      <span>缃戝叧鍋ュ悍</span>
      <span class="diag-muted" id="diagGateway">妫€鏌ヤ腑...</span>
    </div>
    <div class="diag-row">
      <span>璁块棶妯″紡</span>
      <span id="diagAccess" class="diag-muted">__ACCESS_MODE__</span>
    </div>
    <div class="diag-row">
      <span>瀹夊叏涓婁笅鏂?/span>
      <span id="diagSecure" class="diag-muted">妫€鏌ヤ腑...</span>
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
    <div class="mini-note">杩欓噷鍙樉绀哄綋鍓嶅凡鍚敤鐨勮兘鍔涚姸鎬侊紱鏈惎鐢ㄧ殑 MCP / Web Search / Memory Search 浼氳嚜鍔ㄩ殣钘忋€?/div>
  </div>

  <div id="wizardCard" class="hidden"></div>

  <details>
    <summary>浠ょ墝涓庤繛鎺ュ府鍔?/summary>
    <div class="details-body">
      鍦?HAOS 涓紝杩欎釜钀藉湴椤靛氨鏄€绘帶鍏ュ彛銆備娇鐢?<b>鎵撳紑鍘熺敓 Gateway 鐣岄潰</b> 鍙湪鏂版爣绛鹃〉杩涘叆 OpenClaw 瀹屾暣鎺у埗鐣岄潰銆傚鏋滅綉鍏宠姹傝緭鍏ヤ护鐗岋紝涔熷彲浠ュ湪鎻掍欢缁堢閲岃鍙栵細
      <pre>jq -r '.gateway.auth.token' /config/.openclaw/openclaw.json</pre>
      杩欎釜椤甸潰璋冪敤鐨勬槸 OpenClaw 瀹樻柟缃戝叧鎺у埗鍛戒护锛?      <pre>openclaw gateway status
openclaw gateway restart</pre>
      濡傛灉闇€瑕佽澶囬厤瀵癸細
      <pre>openclaw devices list
openclaw devices approve &lt;requestId&gt;</pre>
    </div>
  </details>

  <details>
    <summary>MCP 璁剧疆</summary>
    <div class="details-body">
      <b>鑷姩閰嶇疆</b>
      <ol>
        <li>鍒涘缓涓€涓?Home Assistant 闀挎湡璁块棶浠ょ墝銆?/li>
        <li>濉啓 <code>homeassistant_token</code>銆?/li>
        <li>鍚敤 <code>auto_configure_mcp</code>銆?/li>
        <li>閲嶅惎鎻掍欢銆?/li>
      </ol>
      <div class="hero-sub" style="margin:8px 0 10px">
        褰撳墠闀滃儚濡傛灉娌℃湁鍐呯疆 <code>mcporter</code>锛岄〉闈細鏄庣‘鎻愮ず鈥滅己灏?mcporter鈥濓紝杩欐椂闇€瑕佺瓑鍚庣画闀滃儚琛ラ綈锛屾垨鍦ㄧ粓绔噷鎵嬪姩鎻愪緵璇ュ伐鍏峰悗鍐嶆敞鍐屻€?      </div>
      <b>鎵嬪姩閰嶇疆</b>
      <pre>mcporter config add HA "http://localhost:8123/api/mcp" \
  --header "Authorization=Bearer YOUR_TOKEN" \
  --scope home</pre>
    </div>
  </details>

  <div class="card card-sticky" style="padding:12px">
    <div class="card-title" style="margin-bottom:8px">缁堢</div>
    <div class="term-wrap">
      <div class="term-placeholder" id="termPlaceholder">
        <strong>缁堢鎸夐渶鍔犺浇</strong>
        <span>棣栨鐐瑰嚮杩欓噷鎴栨墽琛屽揩鎹峰懡浠ゆ椂鍐嶅惎鍔ㄧ粓绔紝鍑忓皯椤甸潰棣栧睆鍗￠】鍜屽悗鍙拌祫婧愬崰鐢ㄣ€?/span>
        <button class="term-chip" id="termLoadBtn" type="button">鍔犺浇缁堢</button>
      </div>
      <iframe id="termFrame" data-src="./terminal/" title="缁堢" loading="lazy" class="hidden"></iframe>
    </div>
  </div>
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
  var tokenValue = "";
  var terminalLoading = null;
  var gatewayPollTimer = null;

  function $(id) {
    return document.getElementById(id);
  }

  function ingressUrl(path) {
    var cleaned = String(path || "").replace(/^\/+/, "");
    var base = window.location.href.split("#")[0];
    if (!/\/$/.test(base)) {
      base += "/";
    }
    return new URL(cleaned, base).toString();
  }

  function withTokenHash(url, token) {
    if (!url || !token) {
      return url;
    }
    return String(url).replace(/#.*$/, "") + "#token=" + encodeURIComponent(token);
  }

  function findTerminalTextarea(doc) {
    if (!doc) {
      return null;
    }
    return doc.querySelector(".xterm-helper-textarea, textarea.xterm-helper-textarea, textarea");
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
      try {
        if (document.execCommand("copy")) {
          document.body.removeChild(ta);
          resolve();
          return;
        }
      } catch (_err) {}
      document.body.removeChild(ta);
      reject(new Error("copy_failed"));
    });
  }

  function flashButtonText(id, successText, idleText) {
    var el = $(id);
    if (!el) {
      return;
    }
    el.textContent = successText;
    setTimeout(function () {
      el.textContent = idleText;
    }, 1500);
  }

  function setButtonState(id, disabled) {
    var el = $(id);
    if (!el) {
      return;
    }
    el.disabled = !!disabled;
  }

  function barColor(pct) {
    return pct >= 90 ? "bar-red" : pct >= 70 ? "bar-amber" : "bar-green";
  }

  function setBar(id, pct) {
    var el = $(id);
    var value = Number(pct);
    if (!el || Number.isNaN(value)) {
      return;
    }
    el.style.width = Math.max(0, Math.min(value, 100)) + "%";
    el.className = "bar " + barColor(value);
  }

  function setHealthState(ok, message) {
    var dot = $("statusDot");
    var txt = $("statusText");
    var badges = $("statusBadges");
    var diag = $("diagGateway");
    if (dot) {
      dot.className = ok ? "dot dot-green" : "dot dot-red";
    }
    if (txt) {
      txt.textContent = message || (ok ? "\u8fd0\u884c\u4e2d" : "\u4e0d\u53ef\u7528");
      txt.style.color = ok ? "var(--green)" : "var(--red)";
    }
    if (badges) {
      badges.innerHTML = ok
        ? '<span class="badge badge-green">\u7f51\u5173\u6b63\u5e38</span>'
        : '<span class="badge badge-amber">\u8bf7\u68c0\u67e5\u914d\u7f6e</span>';
    }
    if (diag) {
      diag.textContent = ok ? "\u6b63\u5e38" : "\u4e0d\u53ef\u7528";
      diag.className = ok ? "diag-ok" : "diag-err";
    }
  }

  function setActionFeedback() {
    var panel = $("actionPanel");
    if (panel) {
      panel.classList.add("hidden");
    }
  }

  function ensureTerminalReady() {
    var frame = $("termFrame");
    var placeholder = $("termPlaceholder");
    var loadBtn = $("termLoadBtn");
    if (!frame) {
      return Promise.reject(new Error("missing-frame"));
    }
    if (frame.dataset.loaded === "true") {
      return Promise.resolve(frame);
    }
    if (terminalLoading) {
      return terminalLoading;
    }
    terminalLoading = new Promise(function (resolve) {
      function markReady() {
        frame.dataset.loaded = "true";
        frame.classList.remove("hidden");
        if (placeholder) {
          placeholder.classList.add("hidden");
        }
        resolve(frame);
      }

      if (placeholder) {
        var strong = placeholder.querySelector("strong");
        var hint = placeholder.querySelector("span");
        if (strong) {
          strong.textContent = "\u6b63\u5728\u52a0\u8f7d\u7ec8\u7aef";
        }
        if (hint) {
          hint.textContent = "\u9996\u6b21\u52a0\u8f7d\u53ef\u80fd\u9700\u8981\u51e0\u79d2\uff0c\u5b8c\u6210\u540e\u4f1a\u81ea\u52a8\u5207\u6362\u5230\u5185\u5d4c\u7ec8\u7aef\u3002";
        }
      }
      if (loadBtn) {
        loadBtn.disabled = true;
      }

      frame.addEventListener("load", function handleLoad() {
        frame.removeEventListener("load", handleLoad);
        markReady();
      }, { once: true });
      frame.src = frame.getAttribute("data-src") || "./terminal/";
      setTimeout(function () {
        if (frame.dataset.loaded !== "true") {
          markReady();
        }
      }, 2500);
    }).finally(function () {
      var btn = $("termLoadBtn");
      if (btn) {
        btn.disabled = false;
      }
    });
    return terminalLoading;
  }

  function injectCommandToTerminal(command, submit) {
    var frame = $("termFrame");
    ensureTerminalReady()
      .then(function () {
        if (!frame || !frame.contentWindow) {
          throw new Error("terminal-not-ready");
        }
        var input = findTerminalTextarea(frame.contentWindow.document);
        if (!input) {
          throw new Error("terminal-input");
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
        setActionFeedback();
      })
      .catch(function () {});
  }

  function normalizePidRow() {
    var kept = false;
    Array.prototype.forEach.call(document.querySelectorAll(".kv"), function (row) {
      var badges = row.querySelectorAll(".badge");
      if (badges.length !== 4) {
        return;
      }
      if (!/^nginx\s+/i.test(badges[1].textContent.trim()) || !/^ttyd\s+/i.test(badges[2].textContent.trim())) {
        return;
      }
      var key = row.querySelector(".kv-key");
      if (key) {
        key.textContent = "PID";
      }
      badges[0].textContent = "Gateway " + badges[0].textContent.trim().split(/\s+/).pop();
      badges[1].textContent = "nginx " + badges[1].textContent.trim().split(/\s+/).pop();
      badges[2].textContent = "ttyd " + badges[2].textContent.trim().split(/\s+/).pop();
      badges[3].textContent = "Action " + badges[3].textContent.trim().split(/\s+/).pop();
      if (!kept) {
        kept = true;
        row.classList.remove("hidden");
      } else {
        row.classList.add("hidden");
      }
    });
  }

  function normalizeLocalCopy() {
    var guideCards = document.querySelectorAll(".guide-card");
    if (guideCards[0]) {
      guideCards[0].innerHTML =
        "<h3>\u914d\u7f6e\u9875\u8d1f\u8d23</h3>" +
        "<ul>" +
        "<li><code>Home Assistant Token</code>\u3001MCP\u3001\u8bbf\u95ee\u6a21\u5f0f\u3001\u7aef\u53e3\u7b49 add-on \u53c2\u6570</li>" +
        "<li><code>Brave Search</code>\u3001<code>Gemini Memory Search</code> \u8fd9\u7c7b\u80fd\u529b\u5f00\u5173</li>" +
        "<li>\u4fdd\u5b58\u5e76\u91cd\u542f add-on \u540e\u81ea\u52a8\u751f\u6548</li>" +
        "</ul>";
    }
    if (guideCards[1]) {
      guideCards[1].innerHTML =
        "<h3>\u7ec8\u7aef\u91cc\u7684 <code>openclaw onboard</code></h3>" +
        "<ul>" +
        "<li>\u767b\u5f55\u4e3b\u6a21\u578b\u8d26\u53f7 / OAuth</li>" +
        "<li>\u9009\u62e9\u9ed8\u8ba4\u804a\u5929\u6a21\u578b\u3001channels\u3001hooks</li>" +
        "<li>\u66f4\u9002\u5408\u9996\u6b21\u521d\u59cb\u5316\uff0c\u4e0d\u5efa\u8bae\u6bcf\u6b21\u542f\u52a8\u90fd\u91cd\u590d\u64cd\u4f5c</li>" +
        "</ul>";
    }

    var notes = document.querySelectorAll(".mini-note");
    if (notes[0]) {
      notes[0].innerHTML = "\u5efa\u8bae\uff1a\u914d\u7f6e\u9875\u8d1f\u8d23 add-on \u53c2\u6570\uff0c<code>openclaw onboard</code> \u8d1f\u8d23 OpenClaw \u81ea\u8eab\u521d\u59cb\u5316\u3002";
    }
    if (notes[1]) {
      notes[1].textContent = "\u8fd9\u91cc\u53ea\u663e\u793a\u5f53\u524d\u5df2\u542f\u7528\u7684\u80fd\u529b\u72b6\u6001\uff1b\u672a\u542f\u7528\u7684 MCP / Web Search / Memory Search \u4f1a\u81ea\u52a8\u9690\u85cf\u3002";
    }

    var subtitles = document.querySelectorAll(".section-subtitle");
    if (subtitles[0]) { subtitles[0].textContent = "\u914d\u5bf9\u4e0e\u521d\u59cb\u5316"; }
    if (subtitles[1]) { subtitles[1].textContent = "\u8bca\u65ad\u4e0e\u7ef4\u62a4"; }
    if (subtitles[2]) { subtitles[2].textContent = "\u5907\u4efd\u4e0e\u6062\u590d"; }
  }

  function updateStaticView() {
    var diskPct = parseInt(DISK_PCT, 10);
    var memPct = parseInt(MEM_PCT, 10);
    var cpuPct = parseFloat(CPU_PCT);
    var modeBadge = $("modeBadge");
    var diagAccess = $("diagAccess");
    var gatewayModeText = $("gatewayModeText");
    var secureEl = $("diagSecure");
    var certBtn = $("certBtn");
    var accessEl = $("diagAccess");
    var gatewayCopyBtn = $("gatewayCopyBtn");
    var tokenRow = $("tokenRow");
    var gwBtn = $("gwBtn");

    setBar("diskBar", diskPct);
    setBar("memBar", memPct);
    setBar("cpuBar", cpuPct);

    if (!Number.isNaN(diskPct) && diskPct >= 75 && $("diskBanner")) {
      $("diskBanner").classList.remove("hidden");
      $("diskBanner").textContent = "\u78c1\u76d8\u5df2\u4f7f\u7528 " + DISK_PCT + "%\uff0c\u5269\u4f59\u7a7a\u95f4 " + DISK_AVAIL + "\u3002";
    }
    if (ACCESS_MODE === "custom" && $("migrationBanner")) {
      $("migrationBanner").classList.remove("hidden");
    }

    if (modeBadge) {
      var modeColors = {
        lan_https: "badge-green",
        tailnet_https: "badge-green",
        lan_reverse_proxy: "badge-blue",
        local_only: "badge-gray",
        custom: "badge-amber"
      };
      modeBadge.className = "badge " + (modeColors[ACCESS_MODE] || "badge-gray");
      modeBadge.textContent = ACCESS_MODE_LABELS[ACCESS_MODE] || ACCESS_MODE;
      modeBadge.title = ACCESS_MODE;
    }
    if (diagAccess) {
      diagAccess.textContent = ACCESS_MODE_LABELS[ACCESS_MODE] || ACCESS_MODE;
      diagAccess.title = ACCESS_MODE;
    }
    if (gatewayModeText) {
      gatewayModeText.textContent = GATEWAY_MODE_LABELS[GATEWAY_MODE] || GATEWAY_MODE;
      gatewayModeText.title = GATEWAY_MODE;
    }

    var isSecure =
      location.protocol === "https:" ||
      location.hostname === "localhost" ||
      location.hostname === "127.0.0.1" ||
      location.hostname === "::1";
    var gwUrlIsHttps = /^https:\/\//i.test(GW_URL || "");
    if (secureEl) {
      if (isSecure) {
        secureEl.textContent = "\u5b89\u5168";
        secureEl.className = "diag-ok";
      } else if (ACCESS_MODE === "lan_https" && gwUrlIsHttps) {
        secureEl.textContent = "\u5165\u53e3\u9875\u975e\u5b89\u5168\uff0c\u539f\u751f\u754c\u9762\u5b89\u5168";
        secureEl.className = "diag-warn";
        secureEl.title = "\u5f53\u524d HA Ingress \u9875\u9762\u672c\u8eab\u4e0d\u662f\u5b89\u5168\u4e0a\u4e0b\u6587\uff0c\u4f46\u901a\u8fc7\u4e0a\u65b9\u201c\u6253\u5f00\u539f\u751f Gateway \u754c\u9762\u201d\u8fdb\u5165\u7684 HTTPS \u63a7\u5236\u754c\u9762\u662f\u5b89\u5168\u7684\u3002";
      } else {
        secureEl.textContent = "\u4e0d\u5b89\u5168";
        secureEl.className = "diag-err";
      }
    }

    if (accessEl) {
      if (["lan_https", "tailnet_https", "lan_reverse_proxy"].indexOf(ACCESS_MODE) >= 0) {
        accessEl.className = "diag-ok";
      } else if (ACCESS_MODE === "local_only") {
        accessEl.className = "diag-muted";
      } else {
        accessEl.className = "diag-warn";
      }
    }

    if (ACCESS_MODE === "lan_https" && HTTPS_PORT && certBtn) {
      certBtn.href = "https://" + location.hostname + ":" + HTTPS_PORT + "/openclaw-ca.crt";
      certBtn.classList.remove("hidden");
    }

    if (!GW_URL) {
      if (gatewayCopyBtn) {
        gatewayCopyBtn.disabled = true;
      }
      if (gwBtn) {
        gwBtn.classList.add("hidden");
      }
    }
    if (!TOKEN_AVAILABLE && tokenRow) {
      tokenRow.classList.add("hidden");
    }
    if (GATEWAY_MODE === "remote") {
      setButtonState("gatewayStatusBtn", true);
      setButtonState("gatewayRestartBtn", true);
    }
    if ($("gatewayUrlText")) {
      $("gatewayUrlText").textContent = GW_URL || "-";
      $("gatewayUrlText").title = GW_URL || "";
    }
  }

  function updateDiagSections() {
    var mcpEl = $("diagMcp");
    var webRow = $("diagWebRow");
    var webEl = $("diagWeb");
    var memoryRow = $("diagMemoryRow");
    var memoryEl = $("diagMemory");

    if (mcpEl) {
      var raw = String(mcpEl.textContent || "").trim().toLowerCase();
      var mcpRow = mcpEl.closest(".diag-row");
      if (raw === "registered" || raw === "enabled") {
        mcpEl.textContent = "\u5df2\u6ce8\u518c";
        mcpEl.className = "diag-ok";
      } else if (raw === "configured") {
        mcpEl.textContent = "\u5df2\u914d\u7f6e\u5f85\u9a8c\u8bc1";
        mcpEl.className = "diag-warn";
      } else if (raw === "needs-token") {
        mcpEl.textContent = "\u7f3a\u5c11\u4ee4\u724c";
        mcpEl.className = "diag-warn";
      } else if (raw === "mcporter-missing") {
        mcpEl.textContent = "\u7f3a\u5c11 mcporter";
        mcpEl.className = "diag-warn";
      } else if (raw === "disabled" || !raw) {
        mcpEl.textContent = "\u5df2\u5173\u95ed";
        mcpEl.className = "diag-muted";
      } else {
        mcpEl.className = "diag-muted";
      }
      if (mcpRow) {
        if (raw === "disabled" || !raw) {
          mcpRow.classList.add("hidden");
        } else {
          mcpRow.classList.remove("hidden");
        }
      }
    }

    if (webRow && webEl) {
      if (WEB_SEARCH_ENABLED) {
        webEl.textContent = WEB_SEARCH_PROVIDER || "\u5df2\u542f\u7528";
        webEl.className = "diag-ok";
        webRow.classList.remove("hidden");
      } else {
        webRow.classList.add("hidden");
      }
    }

    if (memoryRow && memoryEl) {
      if (MEMORY_SEARCH_ENABLED) {
        var parts = [];
        if (MEMORY_SEARCH_PROVIDER) { parts.push(MEMORY_SEARCH_PROVIDER); }
        if (MEMORY_SEARCH_MODEL) { parts.push(MEMORY_SEARCH_MODEL); }
        memoryEl.textContent = parts.length ? parts.join(" / ") : "\u5df2\u542f\u7528";
        memoryEl.className = "diag-ok";
        memoryRow.classList.remove("hidden");
      } else {
        memoryRow.classList.add("hidden");
      }
    }
  }

  function checkGateway() {
    if (GATEWAY_MODE === "remote" && !GW_URL) {
      setHealthState(false, "\u8bf7\u8bbe\u7f6e gateway_public_url");
      return Promise.resolve();
    }
    var url = GATEWAY_MODE === "remote" ? GW_URL.replace(/\/$/, "") + "/health" : ingressUrl("health");
    return fetch(url, { cache: "no-cache" })
      .then(function (res) {
        if (!res.ok) {
          throw new Error("HTTP " + res.status);
        }
        return res.json().catch(function () { return null; });
      })
      .then(function (data) {
        if (data && data.ok === false) {
          throw new Error(data.error || "health");
        }
        setHealthState(true, GATEWAY_MODE === "remote" ? "\u8fdc\u7a0b\u7f51\u5173\u53ef\u8fbe" : "\u8fd0\u884c\u4e2d");
      })
      .catch(function () {
        setHealthState(false, GATEWAY_MODE === "remote" ? "\u8fdc\u7a0b\u7f51\u5173\u4e0d\u53ef\u8fbe" : "\u4e0d\u53ef\u7528");
      });
  }

  function scheduleGatewayPoll(delay) {
    if (gatewayPollTimer) {
      clearTimeout(gatewayPollTimer);
    }
    gatewayPollTimer = setTimeout(function () {
      if (document.hidden) {
        scheduleGatewayPoll(30000);
        return;
      }
      checkGateway().finally(function () {
        scheduleGatewayPoll(30000);
      });
    }, delay);
  }

  function setupWizardCard() {
    var wizard = $("wizardCard");
    if (!wizard) {
      return;
    }
    if (ACCESS_MODE === "lan_https") {
      wizard.className = "banner banner-ok";
      wizard.textContent = "\u5185\u7f6e HTTPS \u4ee3\u7406\u5df2\u542f\u7528\u3002\u5982\u679c\u5e0c\u671b\u624b\u673a\u6216\u5e73\u677f\u6d4f\u89c8\u5668\u4fe1\u4efb\u672c\u5730\u8bc1\u4e66\uff0c\u8bf7\u5b89\u88c5 CA \u8bc1\u4e66\u3002";
    } else if (GATEWAY_MODE === "local") {
      wizard.className = "banner banner-info";
      wizard.textContent = "Gateway \u5f53\u524d\u53ea\u7ed1\u5b9a\u5728\u672c\u673a\u56de\u73af\u5730\u5740\u3002\u5982\u679c\u9700\u8981\u5c40\u57df\u7f51\u8bbf\u95ee\uff0c\u8bf7\u4f7f\u7528 lan_https \u6216\u53cd\u5411\u4ee3\u7406\u3002";
    } else {
      wizard.className = "banner banner-info";
      wizard.textContent = "\u8fd9\u4e2a\u63d2\u4ef6\u5f53\u524d\u8fde\u63a5\u7684\u662f\u8fdc\u7a0b\u7f51\u5173\u3002\u8bf7\u786e\u8ba4 gateway_public_url \u6307\u5411\u771f\u5b9e\u7684\u8fdc\u7a0b\u63a7\u5236\u754c\u9762\u3002";
    }
    wizard.classList.remove("hidden");
  }

  function fetchToken() {
    if (tokenValue) {
      return Promise.resolve(tokenValue);
    }
    return fetch(ingressUrl("token"), { cache: "no-cache" })
      .then(function (response) {
        if (!response.ok) {
          throw new Error("token");
        }
        return response.text();
      })
      .then(function (text) {
        tokenValue = String(text || "").trim();
        if (!tokenValue) {
          throw new Error("empty");
        }
        if ($("tokenDisplay")) {
          $("tokenDisplay").textContent = tokenValue;
        }
        if ($("tokenRevealBtn")) {
          $("tokenRevealBtn").classList.add("hidden");
        }
        if ($("tokenCopyBtn")) {
          $("tokenCopyBtn").classList.remove("hidden");
        }
        return tokenValue;
      });
  }

  function bindEvents() {
    var gwBtn = $("gwBtn");
    var tokenRevealBtn = $("tokenRevealBtn");
    var tokenCopyBtn = $("tokenCopyBtn");
    var tokenDisplay = $("tokenDisplay");
    var gatewayCopyBtn = $("gatewayCopyBtn");
    var gatewayUrlText = $("gatewayUrlText");
    var termLoadBtn = $("termLoadBtn");
    var termPlaceholder = $("termPlaceholder");

    if (gwBtn) {
      gwBtn.addEventListener("click", function (event) {
        if (!GW_URL || !TOKEN_AVAILABLE) {
          return;
        }
        event.preventDefault();
        fetchToken()
          .then(function (token) {
            window.open(withTokenHash(gwBtn.href, token), "_blank", "noopener,noreferrer");
          })
          .catch(function () {
            window.open(gwBtn.href, "_blank", "noopener,noreferrer");
          });
      });
    }

    if (tokenRevealBtn) {
      tokenRevealBtn.addEventListener("click", function () {
        fetchToken().catch(function () {});
      });
    }

    if (tokenCopyBtn) {
      tokenCopyBtn.addEventListener("click", function () {
        copyText(tokenValue || (tokenDisplay ? tokenDisplay.textContent : ""))
          .then(function () { flashButtonText("tokenCopyBtn", "\u5df2\u590d\u5236", "\u590d\u5236"); })
          .catch(function () {});
      });
    }

    if (tokenDisplay) {
      tokenDisplay.addEventListener("click", function () {
        if (!tokenValue) {
          return;
        }
        copyText(tokenValue)
          .then(function () { flashButtonText("tokenCopyBtn", "\u5df2\u590d\u5236", "\u590d\u5236"); })
          .catch(function () {});
      });
    }

    if (gatewayCopyBtn) {
      gatewayCopyBtn.addEventListener("click", function () {
        if (!GW_URL) {
          return;
        }
        copyText(GW_URL)
          .then(function () {
            flashButtonText("gatewayCopyBtn", "\u5df2\u590d\u5236", "\u590d\u5236");
            if (gatewayUrlText) {
              gatewayUrlText.textContent = GW_URL;
            }
          })
          .catch(function () {});
      });
    }

    if (gatewayUrlText) {
      gatewayUrlText.addEventListener("click", function () {
        if (!GW_URL) {
          return;
        }
        copyText(GW_URL)
          .then(function () { flashButtonText("gatewayCopyBtn", "\u5df2\u590d\u5236", "\u590d\u5236"); })
          .catch(function () {});
      });
    }

    if ($("gatewayStatusBtn")) {
      $("gatewayStatusBtn").addEventListener("click", function () {
        injectCommandToTerminal("openclaw gateway status --deep", true);
      });
    }
    if ($("gatewayRestartBtn")) {
      $("gatewayRestartBtn").addEventListener("click", function () {
        injectCommandToTerminal("openclaw gateway restart", true);
      });
    }
    if ($("checkUpdateBtn")) {
      $("checkUpdateBtn").addEventListener("click", function () {
        injectCommandToTerminal("curl -fsSL https://registry.npmjs.org/openclaw/latest | jq -r '\"npm latest: \" + .version'", true);
      });
    }

    Array.prototype.forEach.call(document.querySelectorAll("[data-term-cmd]"), function (btn) {
      btn.addEventListener("click", function () {
        injectCommandToTerminal(btn.getAttribute("data-term-cmd") || "", false);
      });
    });

    if (termLoadBtn) {
      termLoadBtn.addEventListener("click", function (event) {
        event.stopPropagation();
        ensureTerminalReady();
      });
    }
    if (termPlaceholder) {
      termPlaceholder.addEventListener("click", function () {
        ensureTerminalReady();
      });
    }

    document.addEventListener("visibilitychange", function () {
      if (!document.hidden) {
        scheduleGatewayPoll(300);
      }
    });
  }

  normalizePidRow();
  normalizeLocalCopy();
  updateStaticView();
  updateDiagSections();
  setupWizardCard();
  bindEvents();
  checkGateway();
  scheduleGatewayPoll(30000);
})();
</script>
</body>
</html>

