#!/usr/bin/env bash
# 安装 Custard 手机控制 Skill
#
# 用法:
#   bash install.sh [Token]
#
# 优先 git clone: https://github.com/kymjs/Custard-Skill
# CustardMac「Agent 端口」→「安装 Skill」效果相同
set -euo pipefail

SKILL_NAME="custard-phone-control"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="${CURSOR_SKILLS_DIR:-$HOME/.cursor/skills}/$SKILL_NAME"
TOKEN="${1:-}"
GITHUB_URL="https://github.com/kymjs/Custard-Skill.git"

mkdir -p "$(dirname "$DEST")"

# 备份已有 config.env
TEMP_CONFIG=""
if [[ -f "$DEST/scripts/config.env" ]]; then
  TEMP_CONFIG="$(mktemp)"
  cp "$DEST/scripts/config.env" "$TEMP_CONFIG"
fi

if command -v git >/dev/null 2>&1; then
  if [[ -d "$DEST/.git" ]]; then
    echo "Updating existing clone..."
    git -C "$DEST" pull --ff-only
  else
    echo "Cloning from $GITHUB_URL ..."
    rm -rf "$DEST"
    git clone --depth 1 "$GITHUB_URL" "$DEST"
  fi
elif [[ -f "$SCRIPT_DIR/SKILL.md" ]]; then
  echo "git not found, copying local skill files..."
  rm -rf "$DEST"
  cp -R "$SCRIPT_DIR" "$DEST"
else
  echo "Error: install git or run from skill source directory." >&2
  exit 1
fi

chmod +x "$DEST/scripts/custard-tool" 2>/dev/null || true
chmod +x "$DEST/install.sh" 2>/dev/null || true

CONFIG="$DEST/scripts/config.env"
if [[ -n "$TEMP_CONFIG" && -f "$TEMP_CONFIG" ]]; then
  cp "$TEMP_CONFIG" "$CONFIG"
  rm -f "$TEMP_CONFIG"
  if [[ -n "$TOKEN" ]]; then
    if grep -q '^CUSTARD_AGENT_TOKEN=' "$CONFIG"; then
      sed -i.bak "s/^CUSTARD_AGENT_TOKEN=.*/CUSTARD_AGENT_TOKEN=$TOKEN/" "$CONFIG" && rm -f "$CONFIG.bak"
    else
      echo "CUSTARD_AGENT_TOKEN=$TOKEN" >> "$CONFIG"
    fi
  fi
elif [[ -n "$TOKEN" ]]; then
  cat > "$CONFIG" <<EOF
CUSTARD_AGENT_TOKEN=$TOKEN
CUSTARD_TOOL_HOST=127.0.0.1
CUSTARD_TOOL_PORT=27184
CUSTARD_SKILL_DIR=$DEST
CUSTARD_TOOL_SOURCE=agent
EOF
else
  cp "$DEST/scripts/config.env.example" "$CONFIG"
  echo "CUSTARD_SKILL_DIR=$DEST" >> "$CONFIG"
  echo "CUSTARD_TOOL_SOURCE=agent" >> "$CONFIG"
fi

# 确保 CUSTARD_SKILL_DIR 存在
if ! grep -q '^CUSTARD_SKILL_DIR=' "$CONFIG"; then
  echo "CUSTARD_SKILL_DIR=$DEST" >> "$CONFIG"
fi

echo "Done: $DEST"
echo "Run: bash \"$DEST/scripts/custard-tool\" status"
