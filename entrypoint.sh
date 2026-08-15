#!/bin/sh
set -e

echo "✅ Starting Xray..."
xray run -c /etc/xray/config.json &

sleep 2  # ✅ Short wait — no lag

echo "✅ Starting Nginx..."
nginx -g "daemon off;"
