#!/bin/sh -el

export SERVER_ADDR="$1"
export SERVER_PORT="$2"
export PASSWORD="$3"
export METHOD="$4"
export PROXY_PORT="$5"

export LOCAL_SS_PORT=18800

echo "$SERVER_ADDR $SERVER_PORT $PASSWORD $METHOD"

(
cat <<EOF
{"method":"$METHOD","server":"$SERVER_ADDR","password":"$PASSWORD","server_port":$SERVER_PORT,"timeout":60,"local_address": "127.0.0.1","local_port": $LOCAL_SS_PORT}
EOF
) > /root/ss-local-config.json

cat /root/ss-local-config.json

#config privoxy
sed -i 's/^listen-address.*$/listen-address  0.0.0.0:'$PROXY_PORT'/' /etc/privoxy/config

(
cat <<EOF
forward-socks5 / 127.0.0.1:$LOCAL_SS_PORT .
EOF
) >> /etc/privoxy/config

privoxy --user privoxy /etc/privoxy/config

sslocal -c /root/ss-local-config.json -d start

sh


