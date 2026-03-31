#!/bin/bash
# ================================================
# 优化版 一键部署脚本（sing-box + Nezha + Argo）
# 特点：
#   1. UUID 完全固定（首次运行自动保存到文件，之后永远使用同一个）
#   2. 移除无用的 npm install uuid
#   3. 增加关键变量确认输出，便于调试
#   4. 结构清晰，注释完整
#   5. 增加基础错误检查
# ================================================

set -e  # 遇到错误立即退出

# ==================== 【固定 UUID 配置】====================
UUID_FILE="fixed_uuid.txt"

if [ -f "$UUID_FILE" ]; then
    export UUID=$(cat "$UUID_FILE" | tr -d '\n\r')
    echo "✅ 从文件读取固定 UUID: $UUID"
else
    # 第一次运行时使用你指定的 UUID 并永久保存
    export UUID="f500f108-2d8f-42af-9802-dcfdc42f3b66"
    echo "$UUID" > "$UUID_FILE"
    echo "✅ 已生成并永久保存固定 UUID: $UUID"
fi

# ==================== 【哪吒探针配置】====================
export NEZHA_SERVER=""          # 哪吒面板域名（v1 格式：nezha.xxx.com:8008；v0 格式：nezha.xxx.com）
export NEZHA_PORT=""            # v1 留空；v0 填写端口（443/8443/2096/2087/2083/2053 时自动开启 TLS）
export NEZHA_KEY=""             # v1 填写 NZ_CLIENT_SECRET；v0 填写 Agent 密钥

# ==================== 【Argo 隧道配置】====================
export ARGO_DOMAIN=""           # Argo 自定义域名，留空 = 启用临时隧道
export ARGO_AUTH=""             # Argo Token 或 json 内容，留空 = 启用临时隧道

# ==================== 【其他配置】====================
export NAME="idx"               # 节点名称（建议保持简短）
export CFIP="www.visa.com.tw"   # 优选 IP / 域名（Cloudflare 优选）
export CFPORT=443               # 对应端口（通常 443）
export CHAT_ID=""               # Telegram 推送 Chat ID（留空 = 不推送）
export BOT_TOKEN=""             # Telegram Bot Token（需同时填 Chat ID 才生效）
export UPLOAD_URL=""            # 订阅器地址（merge-sub 项目首页，例如 https://merge.eooce.ggff.net）

# ==================== 【调试输出】====================
echo "=================================================="
echo "🚀 部署参数确认："
echo "   UUID          = $UUID"
echo "   NAME          = $NAME"
echo "   CFIP          = $CFIP"
echo "   CFPORT        = $CFPORT"
echo "   NEZHA_SERVER  = $NEZHA_SERVER"
echo "   ARGO_DOMAIN   = ${ARGO_DOMAIN:-临时隧道}"
echo "   Telegram推送  = ${CHAT_ID:+已启用}"
echo "=================================================="

# ==================== 【执行主部署脚本】====================
echo "⏳ 正在下载并执行 sb.sh 主脚本..."
bash <(curl -Ls https://main.ssss.nyc.mn/sb.sh)

echo "✅ 部署流程执行完毕！"
