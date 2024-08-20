#!/bin/bash

frecuencia=$(awk "NR==13" /home/pi/MMDVMHost/MMDVM.ini)
frecuencia=`expr substr $frecuencia 13 9`
sed -i "76c $frecuencia" /home/pi/status.ini

puerto=$(awk "NR==51" /home/pi/MMDVMHost/MMDVM.ini)
puerto=`expr substr $puerto 15 14`
sed -i "77c $puerto" /home/pi/status.ini

x=$(awk "NR==93" /home/pi/status.ini)

cd /home/pi/MMDVMHost
xterm -geometry 76x10+$x+64  -bg black -fg cyan -fa 'arial' -fs 10x -T DMO -e sudo ./MMDVMHost MMDVM.ini &
