#!/bin/bash

# ==================== 固定 UUID ====================
# 直接固定你想要的 UUID（推荐方式）
export UUID="f500f108-2d8f-42af-9802-dcfdc42f3b66"

# 如果你想让脚本每次都使用同一个 UUID，但又允许第一次自动生成并保存，可以这样：
# if [ -z "$UUID" ]; then
#     UUID=$(cat uuid.txt 2>/dev/null || uuidgen)
#     echo "$UUID" > uuid.txt
#     export UUID
# fi

echo "使用的 UUID: $UUID"

# --- 哪吒探针配置 ---
export NEZHA_SERVER=""          
export NEZHA_PORT=""            
export NEZHA_KEY=""             

# --- Argo 隧道配置 ---
export ARGO_DOMAIN=""           
export ARGO_AUTH=""             

# --- 其他配置 ---
export NAME="idx"               
export CFIP="www.visa.com.tw" 
export CFPORT=443               
export CHAT_ID=""               
export BOT_TOKEN=""             
export UPLOAD_URL=              

# --- 执行主部署脚本 ---
bash <(curl -Ls https://main.ssss.nyc.mn/sb.sh)
