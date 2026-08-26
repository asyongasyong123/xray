#!/bin/sh
set -e

echo "✅ Starting Xray..."
xray run -c /etc/xray/config.json &
XRAY_PID=$!

for i in 1 2 3 4 5 6 7 8 9 10; do
  if nc -z 127.0.0.1 10001; then
    echo "✅ Xray is listening on port 10001"
    break
  fi
  echo "⏳ Waiting Xray... ($i/10)"
  sleep 1
done

echo "✅ Starting Nginx..."
nginx -g "daemon off;"

wait $XRAY_PID
