FROM alpine

MAINTAINER littleqz <littleqz@gmail.com>

RUN echo 'http://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories \
    && apk add -U vim net-tools iproute2  iputils curl lsof tzdata privoxy openrc libsodium python \
    && curl -sSL https://bootstrap.pypa.io/get-pip.py | python \
    && pip install shadowsocks \
    && rm -rf /var/cache/apk/*

#config timezone
ENV TZ 'Asia/Shanghai'
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apk del tzdata

COPY content /

ENTRYPOINT ["/entrypoint.sh"]
