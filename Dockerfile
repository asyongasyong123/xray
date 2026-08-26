FROM alpine:3.20

ENV XRAY_VERSION=1.8.24

# Install only what's needed
RUN apk update --no-cache && apk add --no-cache \
    nginx wget unzip ca-certificates tzdata

# Install Xray (official)
RUN wget -qO /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/download/v${XRAY_VERSION}/Xray-linux-64.zip && \
    unzip -q /tmp/xray.zip -d /usr/local/bin/ && rm /tmp/xray.zip && \
    chmod +x /usr/local/bin/xray

# Clean default configs
RUN rm -rf /etc/nginx/conf.d/* /etc/nginx/http.d/*

# Copy our clean configs
COPY xray.json /etc/xray/config.json
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080

# Start script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
