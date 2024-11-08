#!/bin/bash
# sudo killall socat  
cd /home/pi/A108
sudo socat -d -d pty,link=/dev/virtual1,raw,echo=0 pty,link=/dev/virtual2,raw,echo=0 &
sudo python3 nextion_5.py &