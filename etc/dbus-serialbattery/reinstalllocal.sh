#!/bin/sh

DRIVER_SERIAL=/opt/victronenergy/dbus-serialbattery
DRIVER_PZEM=/opt/victronenergy/pzem
RUN_SERIAL=/opt/victronenergy/service-templates/dbus-serialbattery
RUN_PZEM=/opt/victronenergy/service-templates/pzem
OLD=/opt/victronenergy/service/dbus-serialbattery

# Newer (2.80 and beyond) versions of VenusOS need the root fs remounted rw
if [ -x "/opt/victronenergy/swupdate-scripts/remount-rw.sh" ]; then
  /opt/victronenergy/swupdate-scripts/remount-rw.sh
fi

# Fix original directory layout
if [ -f "/data/conf/serial-starter.d" ]; then
  rm /data/conf/serial-starter.d
fi

if [ -d "$DRIVER_SERIAL" ]; then
  if [ -L "$DRIVER_SERIAL" ]; then
    # Remove old SymLink.
    rm "$DRIVER_SERIAL"
    # Create as folder
    mkdir "$DRIVER_SERIAL"
  fi
else
  # Create folder
  mkdir "$DRIVER_SERIAL"
fi
if [ -d "$DRIVER_PZEM" ]; then
  if [ -L "$DRIVER_PZEM" ]; then
    # Remove old SymLink.
    rm "$DRIVER_PZEM"
    # Create as folder
    mkdir "$DRIVER_PZEM"
  fi
else
  # Create folder
  mkdir "$DRIVER_PZEM"
fi
if [ -d "$RUN_SERIAL" ]; then
  if [ -L "$RUN_SERIAL" ]; then
    # Remove old SymLink.
    rm "$RUN_SERIAL"
    # Create as folder
    mkdir "$RUN_SERIAL"
  fi
else
  # Create folder
  mkdir "$RUN_SERIAL"
fi
if [ -d "$RUN_PZEM" ]; then
  if [ -L "$RUN_PZEM" ]; then
    # Remove old SymLink.
    rm "$RUN_PZEM"
    # Create as folder
    mkdir "$RUN_PZEM"
  fi
else
  # Create folder
  mkdir "$RUN_PZEM"
fi
if [ -d "$OLD" ]; then
  if [ -L "$OLD" ]; then
    # Remove old SymLink.
    rm "$OLD"
  fi
fi

cp -f /data/etc/dbus-serialbattery/* $DRIVER_SERIAL/
cp -rf /data/etc/dbus-serialbattery/service/* $RUN_SERIAL/

# Make scripts executable
chmod +x /opt/victronenergy/dbus-serialbattery/dbus-serialbattery.py

# Install pzem components
cp -f /data/pzem/* $DRIVER_PZEM/
cp -rf /data/pzem/service/ $RUN_PZEM/
