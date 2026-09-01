#!/bin/sh

# Paandaron ang Xray sa background
xray run -config /etc/xray/config.json &

# Paabuton og 1 second para makatukod ug socket ang Xray
sleep 1

# Paandaron ang Nginx sa foreground isip main container process
exec nginx -g "daemon off;"
