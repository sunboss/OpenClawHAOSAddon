<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>OpenClaw HAOS Add-on</title>
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
      --bg: #f3f6fb;
      --bg2: #ffffff;
      --bg3: #edf2f9;
      --border: #d7e0ec;
      --border2: #b8c7da;
      --text: #142033;
      --text2: #415169;
      --text3: #6b7b93;
      --green: #15803d;
      --green-bg: #ecfdf3;
      --green-border: #86efac;
      --blue: #1d4ed8;
      --blue-bg: #e8f0ff;
      --blue-border: #93c5fd;
      --amber: #b45309;
      --amber-bg: #fff4e5;
      --amber-border: #fdba74;
      --red: #b91c1c;
      --red-bg: #fef2f2;
      --red-border: #fca5a5;
      --radius: 10px;
      --radius-sm: 6px;
    }
    body { font-family: "Segoe UI", "Helvetica Neue", system-ui, sans-serif; background: linear-gradient(180deg, #f7f9fc 0%, #eef3f8 100%); color: var(--text); padding: 12px; font-size: 14px; line-height: 1.5; }
    a, button { font: inherit; }
    h2 { font-size: 18px; font-weight: 600; color: var(--text); }
    .page { max-width: 860px; margin: 0 auto; display: flex; flex-direction: column; gap: 10px; }
    .header { display: flex; align-items: center; gap: 10px; padding: 10px 0 6px; }
    .header-logo { font-size: 22px; }
    .header-info { flex: 1; }
    .header-info h2 { margin-bottom: 2px; }
    .header-info .sub { font-size: 12px; color: var(--text3); }
    .card { background: var(--bg2); border: 1px solid var(--border); border-radius: var(--radius); padding: 14px 16px; box-shadow: 0 8px 24px rgba(15, 23, 42, 0.06); }
    .card-title { font-size: 11px; font-weight: 600; color: var(--text3); text-transform: uppercase; letter-spacing: .06em; margin-bottom: 10px; }
    .badge { display: inline-flex; align-items: center; gap: 4px; padding: 2px 8px; border-radius: 20px; font-size: 11px; font-weight: 500; white-space: nowrap; }
    .badge-green { background: var(--green-bg); color: var(--green); border: 1px solid var(--green-border); }
    .badge-blue { background: var(--blue-bg); color: var(--blue); border: 1px solid var(--blue-border); }
    .badge-amber { background: var(--amber-bg); color: var(--amber); border: 1px solid var(--amber-border); }
    .badge-gray { background: var(--bg3); color: var(--text2); border: 1px solid var(--border); }
    .status-row { display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 8px; margin-bottom: 12px; }
    .status-left { display: flex; align-items: center; gap: 8px; }
    .dot { width: 8px; height: 8px; border-radius: 50%; flex-shrink: 0; }
    .dot-green { background: var(--green); box-shadow: 0 0 6px var(--green); }
    .dot-amber { background: var(--amber); }
    .dot-red { background: var(--red); }
    .status-text { font-size: 15px; font-weight: 600; }
    .status-badges { display: flex; gap: 6px; flex-wrap: wrap; }
    .metrics { display: grid; grid-template-columns: repeat(3, 1fr); gap: 8px; margin-bottom: 2px; }
    .metric { background: var(--bg3); border: 1px solid var(--border); border-radius: var(--radius-sm); padding: 10px 12px; }
    .metric-label { font-size: 11px; color: var(--text3); margin-bottom: 4px; }
    .metric-value { font-size: 20px; font-weight: 600; color: var(--text); }
    .metric-sub { font-size: 11px; color: var(--text2); margin-top: 2px; }
    .bar-wrap { height: 3px; background: var(--border); border-radius: 2px; margin-top: 6px; }
    .bar { height: 3px; border-radius: 2px; transition: width .3s; }
    .bar-green { background: var(--green); }
    .bar-amber { background: var(--amber); }
    .bar-red { background: var(--red); }
    .kv-list { display: flex; flex-direction: column; }
    .kv { display: flex; align-items: center; justify-content: space-between; padding: 7px 0; border-bottom: 1px solid var(--border); gap: 12px; }
    .kv:last-child { border-bottom: none; }
    .kv-key { color: var(--text2); white-space: nowrap; flex-shrink: 0; }
    .kv-val { color: var(--text); font-weight: 500; display: flex; align-items: center; gap: 6px; flex-wrap: wrap; justify-content: flex-end; }
    .mono { font-family: ui-monospace, monospace; font-size: 12px; color: var(--text2); }
    .copy-btn { padding: 2px 8px; border: 1px solid var(--border2); border-radius: 4px; background: transparent; color: var(--text2); cursor: pointer; font-size: 11px; }
    .copy-btn:hover, .btn:hover { background: #e2eaf5; color: var(--text); }
    .btn-grid { display: flex; gap: 8px; flex-wrap: wrap; }
    .btn { padding: 8px 14px; border-radius: var(--radius-sm); font-size: 13px; font-weight: 600; cursor: pointer; border: 1px solid var(--border2); background: #f8fbff; color: var(--text); text-decoration: none; display: inline-flex; align-items: center; gap: 6px; }
    .btn-primary { background: var(--blue); color: #fff; border-color: var(--blue); }
    .btn-primary:hover { background: #1e40af; color: #fff; }
    .divider { border: none; border-top: 1px solid var(--border); margin: 10px 0; }
    .hero { display: flex; flex-direction: column; gap: 10px; }
    .hero-title { font-size: 16px; font-weight: 600; }
    .hero-sub { color: var(--text2); font-size: 13px; line-height: 1.7; }
    .diag-row { display: flex; align-items: center; justify-content: space-between; padding: 7px 0; border-bottom: 1px solid var(--border); font-size: 13px; }
    .diag-row:last-child { border-bottom: none; }
    .diag-ok { color: var(--green); }
    .diag-warn { color: var(--amber); }
    .diag-err { color: var(--red); }
    .diag-muted { color: var(--text3); }
    .banner { padding: 10px 14px; border-radius: var(--radius-sm); margin: 0; font-size: 13px; line-height: 1.6; }
    .banner-warn { background: var(--amber-bg); border: 1px solid var(--amber-border); }
    .banner-err { background: var(--red-bg); border: 1px solid var(--red-border); }
    .banner-info { background: var(--blue-bg); border: 1px solid var(--blue-border); }
    .banner-ok { background: var(--green-bg); border: 1px solid var(--green-border); }
    .term-wrap { border: 1px solid var(--border); border-radius: var(--radius-sm); overflow: hidden; height: 55vh; min-height: 320px; margin-top: 2px; }
    .term-wrap iframe { width: 100%; height: 100%; border: 0; background: #000; }
    details { border: 1px solid var(--border); border-radius: var(--radius); overflow: hidden; }
    details > summary { cursor: pointer; padding: 10px 14px; font-size: 13px; color: var(--text2); font-weight: 500; background: var(--bg2); user-select: none; list-style: none; display: flex; justify-content: space-between; align-items: center; }
    details > summary::after { content: "+"; font-size: 16px; color: var(--text3); }
    details[open] > summary::after { content: "-"; }
    .details-body { padding: 12px 14px; background: #f8fbff; font-size: 13px; color: var(--text2); line-height: 1.7; border-top: 1px solid var(--border); }
    .details-body pre { background: #eef4fb; padding: 8px 10px; border-radius: var(--radius-sm); overflow-x: auto; font-size: 12px; font-family: ui-monospace, monospace; margin: 6px 0; }
    .details-body code { background: #eef4fb; padding: 1px 5px; border-radius: 4px; font-size: 12px; font-family: ui-monospace, monospace; }
    .details-body ol, .details-body ul { padding-left: 20px; line-height: 1.9; }
    .hidden { display: none !important; }
    @media (max-width: 700px) {
      .metrics { grid-template-columns: 1fr; }
      .kv { align-items: flex-start; flex-direction: column; }
      .kv-val { justify-content: flex-start; }
    }
  </style>
</head>
<body>
<div class="page">
  <div class="header">
    <div class="header-logo">OC</div>
    <div class="header-info">
      <h2>OpenClaw HAOS Add-on</h2>
      <div class="sub">Home Assistant add-on | version __ADDON_VERSION__</div>
    </div>
    <span class="badge badge-gray" id="modeBadge">__ACCESS_MODE__</span>
  </div>

  <div class="card">
    <div class="card-title">Service Status</div>
    <div class="status-row">
      <div class="status-left">
        <div class="dot dot-amber" id="statusDot"></div>
        <span class="status-text" id="statusText">Checking...</span>
      </div>
      <div class="status-badges" id="statusBadges"></div>
    </div>
    <div class="metrics">
      <div class="metric">
        <div class="metric-label">Disk</div>
        <div class="metric-value">__DISK_PCT__</div>
        <div class="metric-sub">__DISK_USED__ / __DISK_TOTAL__</div>
        <div class="bar-wrap"><div class="bar" id="diskBar" style="width:0%"></div></div>
      </div>
      <div class="metric">
        <div class="metric-label">Memory</div>
        <div class="metric-value">__MEM_PCT__</div>
        <div class="metric-sub">__MEM_USED__ / __MEM_TOTAL__</div>
        <div class="bar-wrap"><div class="bar" id="memBar" style="width:0%"></div></div>
      </div>
      <div class="metric">
        <div class="metric-label">CPU</div>
        <div class="metric-value">__CPU_PCT__%</div>
        <div class="metric-sub">1-minute load proxy</div>
        <div class="bar-wrap"><div class="bar" id="cpuBar" style="width:0%"></div></div>
      </div>
    </div>
  </div>

  <div class="banner banner-err hidden" id="diskBanner">
    Disk space is getting low. Run <code>oc-cleanup</code> in the terminal, or prune Docker images from the HA host shell.
  </div>

  <div class="banner banner-warn hidden" id="migrationBanner">
    <code>access_mode: custom</code> may require extra secure-context setup. <b>lan_https</b> is the simplest supported option for browsers and phones.
  </div>

  <div class="card">
    <div class="card-title">Versions & Access</div>
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
        <span class="kv-key">Gateway mode</span>
        <span class="kv-val"><span class="badge badge-gray">__GATEWAY_MODE__</span></span>
      </div>
      <div class="kv">
        <span class="kv-key">Config directory</span>
        <span class="kv-val mono">/config/.openclaw</span>
      </div>
      <div class="kv">
        <span class="kv-key">Gateway URL</span>
        <span class="kv-val">
          <span class="mono" id="gatewayUrlText">__GATEWAY_PUBLIC_URL__</span>
          <button class="copy-btn" id="gatewayCopyBtn">Copy</button>
        </span>
      </div>
      <div class="kv" id="tokenRow">
        <span class="kv-key">Gateway token</span>
        <span class="kv-val">
          <span class="mono" id="tokenDisplay">Hidden</span>
          <button class="copy-btn" id="tokenRevealBtn">Reveal</button>
          <button class="copy-btn hidden" id="tokenCopyBtn">Copy</button>
        </span>
      </div>
      <div class="kv">
        <span class="kv-key">Ports</span>
        <span class="kv-val">
          <span class="badge badge-blue">Gateway __GATEWAY_PORT__</span>
          <span class="badge badge-gray">Ingress 48099</span>
          <span class="badge badge-gray">Terminal __TERMINAL_PORT__</span>
        </span>
      </div>
    </div>
  </div>

  <div class="card">
    <div class="hero">
      <div class="hero-title">HAOS Control Center</div>
      <div class="hero-sub">
        Use this page as the Home Assistant entry point for OpenClaw. Open the native Gateway UI in a separate tab for the full Control UI, or stay here for health, token, terminal, and access diagnostics.
      </div>
    </div>
    <hr class="divider">
    <div class="card-title">Actions</div>
    <div class="btn-grid">
      <a class="btn btn-primary" id="gwBtn" href="__GATEWAY_PUBLIC_URL____GW_PUBLIC_URL_PATH__" target="_blank" rel="noopener noreferrer">Open Native Gateway UI</a>
      <a class="btn" href="./terminal/" target="_self">Open Terminal</a>
      <a class="btn hidden" id="certBtn" href="" target="_blank" rel="noopener noreferrer">Download CA Certificate</a>
      <button class="btn" id="gatewayStatusBtn">Gateway Status</button>
      <button class="btn" id="gatewayRestartBtn">Restart Gateway</button>
      <button class="btn" id="checkUpdateBtn">Check npm Version</button>
    </div>
    <hr class="divider">
    <div id="actionFeedback" style="margin-top:8px;font-size:12px;color:var(--text2)"></div>
  </div>

  <div class="card">
    <div class="card-title">Quick Diagnostics</div>
    <div class="diag-row">
      <span>Gateway health</span>
      <span class="diag-muted" id="diagGateway">Checking...</span>
    </div>
    <div class="diag-row">
      <span>Access mode</span>
      <span id="diagAccess" class="diag-muted">__ACCESS_MODE__</span>
    </div>
    <div class="diag-row">
      <span>Secure context</span>
      <span id="diagSecure" class="diag-muted">Checking...</span>
    </div>
    <div class="diag-row">
      <span>MCP</span>
      <span class="diag-muted" id="diagMcp">__MCP_STATUS__</span>
    </div>
  </div>

  <div id="wizardCard" class="hidden"></div>

  <details>
    <summary>Token & connection help</summary>
    <div class="details-body">
      In HAOS, this landing page is the switchboard. Use <b>Open Native Gateway UI</b> to enter OpenClaw's full Control UI in a separate tab. If the gateway asks for a token, you can also read it from the add-on terminal:
      <pre>jq -r '.gateway.auth.token' /config/.openclaw/openclaw.json</pre>
      This page uses the official OpenClaw gateway commands for service control:
      <pre>openclaw gateway status
openclaw gateway restart</pre>
      If device pairing is required:
      <pre>openclaw devices list
openclaw devices approve &lt;requestId&gt;</pre>
    </div>
  </details>

  <details>
    <summary>MCP setup</summary>
    <div class="details-body">
      <b>Automatic</b>
      <ol>
        <li>Create a Home Assistant long-lived token.</li>
        <li>Fill in <code>homeassistant_token</code>.</li>
        <li>Enable <code>auto_configure_mcp</code>.</li>
        <li>Restart the add-on.</li>
      </ol>
      <b>Manual</b>
      <pre>mcporter config add HA "http://localhost:8123/api/mcp" \
  --header "Authorization=Bearer YOUR_TOKEN" \
  --scope home</pre>
    </div>
  </details>

  <div class="card" style="padding:12px">
    <div class="card-title" style="margin-bottom:8px">Terminal</div>
    <div class="term-wrap">
      <iframe src="./terminal/" title="Terminal" loading="lazy"></iframe>
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
    return "./" + String(path || "").replace(/^\/+/, "");
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
      txt.textContent = message || "Running";
      txt.style.color = "var(--green)";
      badges.innerHTML = '<span class="badge badge-green">Gateway OK</span>';
      $("diagGateway").textContent = "Healthy";
      $("diagGateway").className = "diag-ok";
    } else {
      dot.className = "dot dot-red";
      txt.textContent = message || "Unavailable";
      txt.style.color = "var(--red)";
      badges.innerHTML = '<span class="badge badge-amber">Check configuration</span>';
      $("diagGateway").textContent = "Unavailable";
      $("diagGateway").className = "diag-err";
    }
  }

  if (DISK_PCT) {
    var dp = parseInt(DISK_PCT, 10);
    setBar("diskBar", dp);
    if (dp >= 75) {
      $("diskBanner").classList.remove("hidden");
      $("diskBanner").textContent = "Disk is " + DISK_PCT + " used. Free space: " + DISK_AVAIL + ".";
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
  $("diagSecure").textContent = isSecure ? "Secure" : "Not secure";
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
      mcpEl.textContent = "Registered";
      mcpEl.className = "diag-ok";
    } else if (!st) {
      mcpEl.textContent = "Not configured";
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
      setHealthState(false, "Set gateway_public_url");
      return;
    }
    var url = GATEWAY_MODE === "remote" ? GW_URL + "/health" : ingressUrl("health");
    try {
      var res = await fetch(url, { cache: "no-cache" });
      if (!res.ok) { throw new Error("HTTP " + res.status); }
      setHealthState(true, GATEWAY_MODE === "remote" ? "Remote gateway reachable" : "Running");
    } catch (_err) {
      setHealthState(false, GATEWAY_MODE === "remote" ? "Remote gateway unreachable" : "Unavailable");
    }
  }

  checkGateway();
  setInterval(checkGateway, 30000);

  var tokenValue = "";
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
        $("tokenDisplay").textContent = "Read it from the terminal with jq.";
      });
  });

  $("tokenCopyBtn") && $("tokenCopyBtn").addEventListener("click", function () {
    if (!tokenValue) { return; }
    navigator.clipboard.writeText(tokenValue).then(function () {
      $("tokenCopyBtn").textContent = "Copied";
      setTimeout(function () { $("tokenCopyBtn").textContent = "Copy"; }, 1500);
    });
  });

  $("gatewayCopyBtn").addEventListener("click", function () {
    if (!GW_URL) { return; }
    navigator.clipboard.writeText(GW_URL).then(function () {
      $("gatewayCopyBtn").textContent = "Copied";
      setTimeout(function () { $("gatewayCopyBtn").textContent = "Copy"; }, 1500);
    });
  });

  function runGatewayAction(action, label) {
    var fb = $("actionFeedback");
    fb.textContent = label + "...";
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
          fb.innerHTML = "<b>" + escapeHtml(label) + " failed.</b><br><pre>" + escapeHtml(output || "No output") + "</pre>";
          return;
        }
        fb.innerHTML = "<b>" + escapeHtml(label) + " completed.</b>" +
          (output ? "<br><pre>" + escapeHtml(output) + "</pre>" : "");
        if (action === "restart") {
          setTimeout(checkGateway, 1500);
        }
      })
      .catch(function () {
        fb.textContent = label + " failed: unable to reach local action service.";
      });
  }

  $("gatewayStatusBtn").addEventListener("click", function () {
    runGatewayAction("status", "Gateway status");
  });

  $("gatewayRestartBtn").addEventListener("click", function () {
    runGatewayAction("restart", "Gateway restart");
  });

  $("checkUpdateBtn").addEventListener("click", function () {
    var fb = $("actionFeedback");
    fb.textContent = "Checking npm registry...";
    fetch("https://registry.npmjs.org/openclaw/latest", { cache: "no-cache" })
      .then(function (r) {
        if (!r.ok) { throw new Error("npm"); }
        return r.json();
      })
      .then(function (d) {
        if (d.version && d.version !== OC_VER) {
          fb.innerHTML = "Latest npm version: <b>" + d.version + "</b> (current: " + OC_VER + ").";
        } else {
          fb.textContent = "Current bundled version is up to date: " + OC_VER + ".";
        }
      })
      .catch(function () {
        fb.textContent = "Unable to reach npm right now.";
      });
  });

  var wizard = $("wizardCard");
  if (ACCESS_MODE === "lan_https") {
    wizard.className = "banner banner-ok";
    wizard.textContent = "Built-in HTTPS proxy is enabled. Install the CA certificate on phones/tablets if you want the browser to trust the local certificate.";
  } else if (ACCESS_MODE === "local_only") {
    wizard.className = "banner banner-info";
    wizard.textContent = "Gateway is only bound to loopback. Use lan_https or a reverse proxy if you want network access.";
  } else if (GATEWAY_MODE === "remote") {
    wizard.className = "banner banner-info";
      wizard.textContent = "This add-on is connected to a remote gateway. Ensure gateway_public_url points to the actual remote Control UI.";
  }
})();
</script>
</body>
</html>
