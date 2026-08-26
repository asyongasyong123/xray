#!/bin/sh
set -e

echo "✅ Starting Xray core..."
xray run -c /etc/xray/config.json &

sleep 2

echo "✅ Starting Nginx..."
exec nginx -g "daemon off;"
