FROM alpine:3.20

ENV XRAY_VERSION=1.8.24

# Install tools, download Xray, unya i-clean up ang build packages
RUN apk add --no-cache nginx wget unzip ca-certificates bash && \
    wget -qO /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/download/v${XRAY_VERSION}/Xray-linux-64.zip && \
    unzip -q /tmp/xray.zip -d /tmp/xray/ && \
    mv /tmp/xray/xray /usr/local/bin/xray && \
    chmod +x /usr/local/bin/xray && \
    rm -rf /tmp/xray* /etc/nginx/conf.d/* /etc/nginx/http.d/* && \
    apk del wget unzip

COPY xray.json /etc/xray/config.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
