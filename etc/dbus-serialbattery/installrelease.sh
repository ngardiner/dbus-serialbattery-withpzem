#!/bin/sh
wget https://github.com/ngardiner/dbus-serialbattery-withpzem/archive/refs/heads/withpzem.tar.gz -O /tmp/venus-data.tar.gz -qi - 
tar -zxf /tmp/venus-data.tar.gz --strip-components=1 -C /data
sh /data/etc/dbus-serialbattery/reinstalllocal.sh
