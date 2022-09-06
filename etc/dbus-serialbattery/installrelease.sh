#!/bin/sh
wget https://github.com/ngardiner/dbus-serialbattery-withpzem/archive/refs/heads/withpzem.tar.gz -O /data/venus-data.tar.gz -qi - 
tar -vzxf /data/venus-data.tar.gz --strip-components=1 -C /data
bash -x /data/etc/dbus-serialbattery/reinstalllocal.sh
