#!/bin/sh
wget https://github.com/ngardiner/dbus-serialbattery-withpzem/archive/refs/heads/withpzem.tar.gz -O venus-data.tar.gz -qi - 
tar -zxf ./venus-data.tar.gz -C /data
sh /data/etc/dbus-serialbattery/reinstalllocal.sh
