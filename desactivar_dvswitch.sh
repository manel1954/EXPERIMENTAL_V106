#!/bin/bash

sudo systemctl stop dmr2ysf.service
sudo systemctl stop analog_bridge.service
sudo systemctl stop ircddbgatewayd.service
sudo systemctl stop md380-emu.service
sudo systemctl stop mmdvm_bridge.service
sudo systemctl stop nxdngateway.service
sudo systemctl stop p25gateway.service
sudo killall ircddbgatewayd
sed -i "18c DVSWITCH=OFF" /home/pi/status.ini
