#!/bin/bash
# ================================================
# 优化版 sb.sh 部署脚本（固定 UUID）
# 专为 Google IDX 使用
# ================================================

set -e  # 遇到错误立即停止

echo "🚀 开始执行优化后的 sb.sh 部署..."

# ==================== 【固定 UUID】====================
UUID_FILE="fixed_uuid.txt"
DESIRED_UUID="f500f108-2d8f-42af-9802-dcfdc42f3b66"

if [ -f "$UUID_FILE" ]; then
    export UUID=$(cat "$UUID_FILE" | tr -d ' \n\r')
    echo "✅ 从文件读取固定 UUID: $UUID"
else
    export UUID="$DESIRED_UUID"
    echo "$UUID" > "$UUID_FILE"
    echo "✅ 已生成并保存固定 UUID: $UUID"
fi

# ==================== 【哪吒探针配置】====================
export NEZHA_SERVER=""          # 填写你的哪吒面板地址
export NEZHA_PORT=""            # v0 需要填端口，v1 一般留空
export NEZHA_KEY=""             # 哪吒密钥

# ==================== 【Argo 隧道配置】====================
export ARGO_DOMAIN=""           # 留空 = 使用临时 Argo 隧道
export ARGO_AUTH=""             # 留空 = 使用临时 Argo 隧道

# ==================== 【其他配置】====================
export NAME="idx"               
export CFIP="www.visa.com.tw"   # 可改成其他优选域名：icook.tw、speed.cloudflare.com 等
export CFPORT=443

export CHAT_ID=""               # Telegram 推送（可选）
export BOT_TOKEN=""             
export UPLOAD_URL=""            # 订阅器地址（可选）

# ==================== 【调试信息】====================
echo "=================================================="
echo "📋 当前部署参数："
echo "   UUID       → $UUID"
echo "   NAME       → $NAME"
echo "   CFIP       → $CFIP"
echo "   Argo       → ${ARGO_DOMAIN:-临时隧道}"
echo "=================================================="

# ==================== 【执行主脚本】====================
echo "⏳ 正在执行 sb.sh 主部署脚本..."
bash <(curl -Ls https://main.ssss.nyc.mn/sb.sh)

echo "✅ 部署执行完毕！"
echo "如需重新部署，请直接运行此脚本。"
