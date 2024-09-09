#!/bin/bash

sed -i "16c DMR2NXDN=ON" /home/pi/status.ini

frecuencia=$(awk "NR==13" /home/pi/MMDVMHost/MMDVMDMR2NXDN.ini)
frecuencia=`expr substr $frecuencia 13 9`
sed -i "92c $frecuencia" /home/pi/status.ini

puerto=$(awk "NR==51" /home/pi/MMDVMHost/MMDVMDMR2NXDN.ini)
puerto=`expr substr $puerto 15 14`
sed -i "93c $puerto" /home/pi/status.ini

cd /home/pi/DMR2NXDN

xterm -geometry 87x7+1287+905 -bg black -fg orange -fa 'serift' -fs 9x -T DMR2NXDN -e sudo ./DMR2NXDN DMR2NXDN.ini &

sleep 2

cd /home/pi/MMDVMHost
xterm -geometry 87x15+1287+643 -bg black -fg orange -fa 'serift' -fs 9x -T MMDVMDMR2NXDN -e sudo ./MMDVMDMR2NXDN MMDVMDMR2NXDN.ini 