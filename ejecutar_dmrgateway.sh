#!/bin/bash

#sudo systemctl stop mmdvm_bridge.service #esto se hace para que funcione el DMRGateway 

mode=`grep -n -m 1 "^Port=" /home/pi/MMDVMHost/MMDVMDMRGateway.ini`
buscar=":"
caracteres=`expr index $mode $buscar`
caracteres_linea=`expr $caracteres - 1`
numero_linea_port=`expr substr $mode 1 $caracteres_linea`
mode=$(awk "NR==$numero_linea_port" /home/pi/MMDVMHost/MMDVMDMRGateway.ini)
puerto=`expr substr $mode 11 9`
puerto="  "$puerto

frecuencia=$(awk "NR==13" /home/pi/MMDVMHost/MMDVMDMRGateway.ini)
frecuencia=`expr substr $frecuencia 13 17`
frecuencia=$frecuencia$puerto
sed -i "11c Name=$frecuencia" /home/pi/RXF_DMRGATEWAY.desktop


cd /home/pi/DMRGateway

xterm -geometry 87x15+1287+643 -bg black -fg white -fa 'serift' -fs 9x -T YSFGateway -e sudo ./DMRGateway DMRGateway.ini &

sleep 2

cd /home/pi/MMDVMHost
xterm -geometry 87x5+1287+832 -bg black -fg white -fa 'serift' -fs 9x -T MMDVMDMRGATEWAY -e sudo ./MMDVMDMRGATEWAY MMDVMDMRGateway.ini 





