#!/bin/bash

sudo killall -9 YSF2DMR
sudo killall -9 MMDVMDMFUSION

sed -i "14c YSF2DMR=OFF" /home/pi/status.ini