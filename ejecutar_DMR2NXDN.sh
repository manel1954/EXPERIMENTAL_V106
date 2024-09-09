#!/bin/bash

frecuencia=$(awk "NR==13" /home/pi/MMDVMHost/MMDVMDMR2NXDN.ini)
frecuencia=`expr substr $frecuencia 13 9`
sed -i "92c $frecuencia" /home/pi/status.ini

puerto=$(awk "NR==51" /home/pi/MMDVMHost/MMDVMDMR2NXDN.ini)
puerto=`expr substr $puerto 15 14`
sed -i "93c $puerto" /home/pi/status.ini

cd /home/pi/DMR2NXDN
xterm -geometry 88x6+1274+665 -bg violet -fg black -fa ‘verdana’ -fs 9x -T CONSOLA_DMR2NXDN -e ./DMR2NXDN DMR2NXDN.ini & 
cd /home/pi/MMDVMHost
#/home/pi/SYSTEM/./qt_info_dmr2nxdn & sudo lxterminal --geometry=75x12 -e ./DMR2NXDN MMDVMDMR2NXDN.ini &
xterm -geometry 88x9+1274+787 -bg violet -fg black -fa ‘verdana’ -fs 9x -T CONSOLA_MMDVMDMR2NXDN -e ./DMR2NXDN MMDVMDMR2NXDN.ini & 
cd /home/pi/NXDNClients/NXDNGateway
xterm -geometry 88x4+1274+0 -bg violet -fg black -fa ‘verdana’ -fs 9x -T CONSOLA_NXDNGateway -e ./NXDNGateway NXDNGateway.ini


