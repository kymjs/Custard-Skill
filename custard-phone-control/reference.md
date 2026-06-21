# Custard Agent API 参考

- Skill 仓库：https://github.com/kymjs/Custard-Skill
- Base URL：`http://127.0.0.1:27184`（**仅 loopback**）

## 命令 ↔ HTTP

| custard-tool | HTTP | Body |
|--------------|------|------|
| `get_screen` | `GET /screen` | — |
| `get_screen --screenshot` | `GET /screen?screenshot=1` | —（超时 90s） |
| `list_apps` | `GET /tool/list_installed_apps` | — |
| `open_app <名>` | `POST /tool/open_app` | `{"package_or_name":"..."}` |
| `tap X Y [action]` | `POST /tool/tap_screen` | `{"x_percent":X,"y_percent":Y,"action":"tap"}` |
| `read_clipboard` | `GET /tool/read_clipboard` | — |
| `write_clipboard <t>` | `POST /tool/write_clipboard` | `{"text":"..."}` |
| `type_text <t>` | `POST /tool/type_text` | `{"text":"..."}` |
| `press_home` | `POST /tool/press_home` | `{}` |
| `press_back` | `POST /tool/press_back` | `{}` |
| `status` | `GET /agent/status` | — |

Headers：

- `X-Custard-Tool-Source: agent`（Skill 默认，映射 MCP 开关）
- `X-Custard-Agent-Token: <token>`（API 开启时必填）

## 工具开关（tool_disabled）

Skill（`source=agent`）→ 检查 **MCP** 类：`mcp.get_screen`、`mcp.tap_screen` 等。

`custard-screen` CLI → `cli.get_screen`。

`GET /agent/status` 的 `tools` 数组包含全部 CLI/MCP 项及 `enabled` 状态。

## 错误码

| HTTP | error | 说明 |
|------|-------|------|
| 401 | unauthorized | Token 错误 |
| 403 | permission_denied | Agent 端口权限 |
| 403 | tool_disabled | 工具页关闭 |
| 429 | rate_limited | 超过 120 次/分钟 |
| 503 | — | 手机未连接 |

## 截图说明

`--screenshot` 返回 JSON 内 `screenshot_base64`，体积大；终端 Agent 通常**无法直接看图**，仅适合具备视觉能力的模型。优先用 UI 树字段判断状态。

## 限制

- 仅本机；Cloud Agent 不可用
- `list_apps` 需 ADB
- `type_text` 中文依赖奶黄包 IME 或 ADB/剪贴板回退
- 日志：`~/Library/Logs/CustardMac/agent-api.log`
