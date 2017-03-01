#!/bin/bash

# Set defaults, can be overriden in /srv/maverick/data/config/mavproxy-fc.conf
ENABLE=true
SCREEN_NAME=mavproxy-fc
MAVPROXY_PORT=/dev/ttyUSB0
MAVPROXY_BAUD=115200
MAVPROXY_ARGS="--out=udpin:0.0.0.0:14555 --out=udpin:0.0.0.0:14556 --out=udpin:0.0.0.0:14557 --out=tcpin:0.0.0.0:5765 --out=tcpin:0.0.0.0:5766 --out=tcpin:0.0.0.0:5767"

[ ! -r /srv/maverick/data/config/mavproxy-fc.conf ] || . /srv/maverick/data/config/mavproxy-fc.conf

if [ "$ENABLE" == "false" ]; then
    echo "ENABLE flag is set to false, exiting"
    exit 0
fi

/usr/bin/screen -L -c /srv/maverick/data/config/mavproxy-fc.screen.conf -S $SCREEN_NAME -d -m /srv/maverick/.virtualenvs/fc/bin/python /srv/maverick/.virtualenvs/fc/bin/mavproxy.py --master $MAVPROXY_PORT --baud $MAVPROXY_BAUD --state-basedir=/srv/maverick/var/log/mavproxy-fc $MAVPROXY_ARGS