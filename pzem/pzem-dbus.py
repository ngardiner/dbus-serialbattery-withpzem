#!/usr/bin/env python

"""
A class to put a simple service on the dbus, according to victron standards, with constantly updating
paths. See example usage below. It is used to generate dummy data for other processes that rely on the
dbus. See files in dbus_vebus_to_pvinverter/test and dbus_vrm/test for other usage examples.
To change a value while testing, without stopping your dummy script and changing its initial value, write
to the dummy data via the dbus. See example.
https://github.com/victronenergy/dbus_vebus_to_pvinverter/tree/master/test
"""
import argparse
import dbus
import dbus.service
import gobject
from gobject import idle_add
import json
import logging
import os
import pzem
import platform
import sys
import time

# our own packages
sys.path.insert(1, os.path.join(os.path.dirname(__file__), 'ext/velib_python'))
from vedbus import VeDbusService, VeDbusItemImport

softwareVersion = '0.1'

AC_INPUT=0
AC_OUTPUT=1

class DbusPzemService:
    def __init__(self, tty, devices):
        self._services = {}
        self._instruments = {}
        devname = os.path.basename(tty)

        for addr in devices:
            if devices[addr] == 'grid':
                self._services[addr] = DbusPzemGridMeterService(devname, addr)
                self._instruments[addr] = pzem.Instrument(tty, addr, 'ac')
            elif devices[addr] == 'inverter0':
                self._services[addr] = DbusPzemInverterService(devname, addr, position=AC_INPUT)
                self._instruments[addr] = pzem.Instrument(tty, addr, 'ac')
            elif devices[addr] == 'inverter':
                self._services[addr] = DbusPzemInverterService(devname, addr)
                self._instruments[addr] = pzem.Instrument(tty, addr, 'ac')
            elif devices[addr] == 'pzem-016':
                self._services[addr] = DbusPzem016Service(devname, addr)
                self._instruments[addr] = pzem.Instrument(tty, addr, 'ac')
            elif devices[addr] == 'mock-multiplus':
                self._services[addr] = DbusMockMultiplusService(devname, addr)
                self._instruments[addr] = None
            else:
                raise Exception("Unknown device type %s" % devices[addr])

        gobject.timeout_add(1000, self._update)

    def _update(self):
        for addr in self._services:
            service, instr = self._services[addr], self._instruments[addr]
            service.update(instr)
        return True

def main():
    from optparse import OptionParser
    parser = OptionParser()
    parser.add_option("-d", "--device", dest="device", default="/dev/ttyUSB0",
                      help="tty device", metavar="ADDRESS")
    parser.add_option("-a", "--address", dest="address", type="int",
                      help="device address", metavar="ADDRESS", default=0xF8)
    parser.add_option("--change-address", dest="change_address", type="int",
                      help="change device address", metavar="ADDRESS")
    parser.add_option("-t", "--type", dest="type",
                      help="Type (ac, dc)", metavar="TYPE")
    parser.add_option("--debug", dest="debug", action="store_true", help="set logging level to debug")
    (opts, args) = parser.parse_args()

    logging.basicConfig(level=(logging.DEBUG if opts.debug else logging.INFO))

    from dbus.mainloop.glib import DBusGMainLoop

    # Have a mainloop, so we can send/receive asynchronous calls to and from dbus
    DBusGMainLoop(set_as_default=True)

    # Load config file
    f = open('/data/conf/pzem.conf.json');
    
    DbusPzemService(
        tty=opts.device,
        devices=json.load(f)
    )
    
    # Close config file
    f.close()

    logging.info("Starting mainloop, responding only on events")
    mainloop = gobject.MainLoop()
    mainloop.run()

if __name__ == "__main__":
    main()
