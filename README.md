# dbus-serialbattery-withpzem
This is a driver for VenusOS devices (any GX device sold by Victron or a Raspberry Pi running the VenusOS image). 

It is a consolidation of the [dbus-serialbattery](https://github.com/Louisvdw/dbus-serialbattery) driver, with additional peacefair pzem shunt support from [venusos-peacefair-pzem](https://github.com/mildred/venusos-peacefair-pzem).

The pzem shunt support will allow measuring either inverter load or battery voltage and power draw from PZEM-016 (AC) and PZEM-017 (DC) shunt devices.

The driver will communicate with a Battery Management System (BMS) that support serial communication (TTL, RS232 or RS485) 
Modbus RTU type commands and publish this data to the dbus used by VenusOS. The main purpose is to supply up to date 
State Of Charge (SOC), Voltage & Current values to the inverter so that your serial battery can be set as the Battery Monitor in the ESS settings. Many extra parameters and alarms are also published if available from the BMS.

 * [BMS Types supported](https://github.com/Louisvdw/dbus-serialbattery/wiki/BMS-types-supported)
 * [FAQ](https://github.com/Louisvdw/dbus-serialbattery/wiki/FAQ)
 * [Features](https://github.com/Louisvdw/dbus-serialbattery/wiki/Features)
 * [How to install](https://github.com/ngardiner/dbus-serialbattery-withpzem/tree/withpzem/docs/install.md)
 * [Troubleshoot](https://github.com/Louisvdw/dbus-serialbattery/wiki/Troubleshoot)

### Donations:
If you would like to donate to this project, you can buy [Louisvdw](https://github.com/Louisvdw/dbus-serialbattery) a Ko-Fi. Visit the link to the project.
