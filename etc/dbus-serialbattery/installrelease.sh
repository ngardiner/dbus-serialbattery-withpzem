#!/bin/sh
wget -q https://github.com/ngardiner/dbus-serialbattery-withpzem/archive/refs/heads/withpzem.tar.gz -O /data/venus-data.tar.gz
tar -vzxf /data/venus-data.tar.gz --strip-components=1 -C /data
bash -x /data/etc/dbus-serialbattery/reinstalllocal.sh
