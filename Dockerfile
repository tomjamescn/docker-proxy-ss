FROM littleqz/openwrt

MAINTAINER littleqz <qizhihere@gmail.com>

RUN mkdir -p /var/lock && \
    opkg update && \
    opkg install shadowsocks-libev; return 0

ENV SERVER 0.0.0.0
ENV SERVER_PORT 998
ENV LOCAL_PORT 1080
ENV PASSWORD default
ENV METHOD aes-256-cfb
ENV TIMEOUT 300

EXPOSE $LOCAL_PORT

CMD ss-redir -s "$SERVER" \
             -p "$SERVER_PORT" \
             -l "$LOCAL_PORT" \
             -k "$PASSWORD" \
             -m "$METHOD" \
             -t "$TIMEOUT"
