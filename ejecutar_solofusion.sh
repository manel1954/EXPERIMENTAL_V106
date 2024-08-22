#!/bin/bash

frecuencia=$(awk "NR==13" /home/pi/MMDVMHost/MMDVMFUSION.ini)
frecuencia=`expr substr $frecuencia 13 9`
sed -i "78c $frecuencia" /home/pi/status.ini

puerto=$(awk "NR==51" /home/pi/MMDVMHost/MMDVMFUSION.ini)
puerto=`expr substr $puerto 15 14`
sed -i "79c $puerto" /home/pi/status.ini

cd /home/pi/YSFClients/YSFGateway
xterm -geometry 77x5+1287+888 -bg black -fg orange -fa 'serift' -fs 10x -T CONSOLA_YSFGateway -e ./YSFGateway YSFGateway.ini & 
cd /home/pi/MMDVMHost
xterm -geometry 76x5+1287+999 -bg black -fg orange -fa 'serift' -fs 10x -T CONSOLA_SOLOFUSION -e sudo ./MMDVMFUSION MMDVMFUSION.ini

