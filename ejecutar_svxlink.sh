#!/bin/bash
sed -i "8c SVXLINK=ON" /home/pi/status.ini
xterm -geometry 88x17+1285+745 -bg black -fg cyan -fa 'serift' -fs 9x -T SVXLINK -e sudo svxlink
