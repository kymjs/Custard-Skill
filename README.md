# 让 AI 替你操作手机 — Custard 手机控制 Skill

> 一句话：**Custard 把 Android 手机接到 Mac 上，这个 Skill 可以让任何 Agent 能「看见」并「操控」你的 Android 手机。**

---

## 这个 Skill 是干什么的？

安装 **custard-phone-control** 之后，你在 Cursor 里对 AI 说：

- 「帮我打开微信，给张三发一条消息：今晚见」
- 「看看我手机现在是什么界面」
- 「把这段文字复制到手机剪贴板」
- 「点一下屏幕中间那个按钮」

AI 会通过本机 API 读屏、点击、输入、开应用——**你不用再反复拿起手机操作**。

> 前提：Mac 上运行 CustardMac，手机已连接，并在 CustardMac 里开启「Agent 端口」并安装本 Skill。

---

## 另外 Custard 是什么？

### 低延迟真·投屏，不是 PPT 翻页

Custard 用 **H.264 硬件编码**（手机端 MediaCodec + Mac 端 VideoToolbox），画面跟手、延迟低。你在 Mac 上用鼠标点、键盘打，手机立刻响应——像在用一块外接触摸屏。

### 插线就能用，不折腾 WiFi

- **USB 连接**：数据线插上，点「USB 连接」，免配网
- **WiFi 直连**：同一局域网也行

两种通道都支持远程触控和键盘输入，日常开发、演示、远程协助都顺手。

### Mac ↔ 手机剪贴板互通

电脑上复制的链接、代码、文字，手机粘贴就有；手机复制的内容，Mac 也能直接拿到。**跨设备协作少切一次屏。**

### 为大模型而生的「眼睛」和「手」

Custard 不只是投屏工具，它给 AI 装上了：

| 能力 | 说明 |
|------|------|
| **读屏** | 获取当前界面结构、前台应用，可选附带截图 |
| **点击 / 滑动** | 百分比坐标，AI 不用猜像素 |
| **输入文字** | 支持中文（奶黄包输入法） |
| **开应用** | 说「打开微信」就行 |
| **Home / 返回** | 系统导航一键完成 |
| **剪贴板读写** | 跨设备传内容 |

内置聊天、Cursor Skill、MCP、本地 HTTP API——**同一套能力，多种用法**，你用什么 AI 工具都能接上。

### 安全在本机

Agent API 只监听 `127.0.0.1`，不暴露到公网。Token 鉴权、工具开关、操作审计日志——**你能控什么、AI 能做什么，一目了然。**

### 一键安装 Skill

CustardMac → **Agent 端口** → 点 **「安装 Skill」**，自动克隆仓库、写好配置。不用手敲命令，30 秒搞定。

---

## 三分钟上手

### 1. 安装 Custard

1. Mac 打开 **CustardMac**，连接手机会自动安装 **Custard Android**
2. 手机开启无障碍服务，授权屏幕录制
3. USB 或 WiFi 连接成功（CustardMac 显示已连接）

### 2. 安装本 Skill

在 CustardMac 的 **Agent 端口** 页面：

1. 开启 Agent API
2. 点击 **「安装 Skill」**

或手动：

```bash
git clone --depth 1 https://github.com/kymjs/Custard-Skill.git \
  ~/.cursor/skills/custard-phone-control
```

然后在 `scripts/config.env` 里填入 CustardMac 显示的 Token。

### 3. 验证

```bash
bash ~/.cursor/skills/custard-phone-control/scripts/custard-tool status
```

看到 `phone_connected: true`，就可以在 Cursor 里让 AI 操作手机了。

---

## 试试这些指令

在 Cursor 对话里直接说（需本机 Agent，Cloud Agent 无法访问 localhost）：

```
帮我看一下手机现在在什么界面
```

```
打开微信，点搜索框，输入「奶黄包」
```

```
把手机剪贴板的内容读给我
```

AI 会自动调用读屏、点击、输入等能力——**你描述目标，它执行步骤。**

---

## 常见问题

**Q：iPhone 手机能用吗？**  
目前仅支持 **Android**，也在做 **iOS**、**Harmony**版本，但**iOS**复杂度更高，需要等一段时间。  

**Q：必须安装 Agent 才能用 Custard 吗？**  
不必须，Custard 本身就是一个 Agent，完全不需要其他 Agent。

**Q：支持哪些三方 Agent？**  
Custard 已适配的 Agent 有：Hermes、OpenClaw、Cursor、Codex。其他国产Agent没有做单独测试，但理论上也能支持。

**Q：Cloud Agent 能用吗？**  
不能。API 在本机，请用 **本机 Agent**。

**Q：银行或股票证券 App 能调用吗？**  
部分安全界面（FLAG_SECURE）无法截图或读 UI，这是系统限制。大部分证券 APP 都能正常使用。

---

## 链接

- **Skill 仓库**：[github.com/kymjs/Custard-Skill](https://github.com/kymjs/Custard-Skill)
- **Custard 主项目**：[https://github.com/kymjs/Custard](https://github.com/kymjs/Custard) 注意：第二代 Custard 暂时仅支持邀请试用，目前仅面向中国大陆(除港澳台琼地区外)提供第一代纯客户端版本。  

---

**装好 Custard + 本 Skill，你的 Mac 就不只是电脑——它是 AI 遥控你手机的指挥台。**
