FROM alpine:3.20

ENV XRAY_VERSION=1.8.24
ENV XRAY_LOCATION_ASSET=/usr/local/share/xray

# Install dependencies, setup directories, ug download Xray + DAT files
RUN apk add --no-cache nginx wget unzip ca-certificates tzdata && \
    mkdir -p /usr/local/share/xray /run/nginx /etc/xray && \
    wget -qO /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/download/v${XRAY_VERSION}/Xray-linux-64.zip && \
    unzip -q /tmp/xray.zip -d /tmp/xray_extract && \
    mv /tmp/xray_extract/xray /usr/local/bin/xray && \
    mv /tmp/xray_extract/geosite.dat /usr/local/share/xray/geosite.dat && \
    mv /tmp/xray_extract/geoip.dat /usr/local/share/xray/geoip.dat && \
    chmod +x /usr/local/bin/xray && \
    rm -rf /tmp/xray* /etc/nginx/conf.d/* /etc/nginx/http.d/*

# Copy configs
COPY config.json /etc/xray/config.json
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080

# Start script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
