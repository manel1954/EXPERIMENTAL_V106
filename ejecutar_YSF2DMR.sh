#!/bin/bash

sudo killall -9 qt_editor_ysf2dmr

#Colores 
ROJO="\033[1;31m"
VERDE="\033[1;32m"
BLANCO="\033[1;37m"
AMARILLO="\033[1;33m"
CIAN="\033[1;36m"
GRIS="\033[0m"

mode=`grep -n -m 1 "^UARTPort=" /home/pi/MMDVMHost/MMDVMFUSION.ini`
buscar=":"
caracteres=`expr index $mode $buscar`
caracteres_linea=`expr $caracteres - 1`
numero_linea_port=`expr substr $mode 1 $caracteres_linea`
mode=$(awk "NR==$numero_linea_port" /home/pi/MMDVMHost/MMDVMFUSION.ini)
puerto=`expr substr $mode 15 14`
puerto="  "$puerto
cd /home/pi/Desktop
sudo cp RXF_YSF2DMR.desktop /home/pi
frecuencia=$(awk "NR==13" /home/pi/MMDVMHost/MMDVMFUSION.ini)
frecuencia=`expr substr $frecuencia 13 17`
frecuencia=$frecuencia$puerto
sed -i "11c Name=$frecuencia" /home/pi/RXF_YSF2DMR.desktop

sudo cp /home/pi/RXF_YSF2DMR.desktop /home/pi/Desktop

sudo rm /home/pi/RXF_YSF2DMR.desktop

#Escribe en el fichero INFO_RXF para poner los datos en los iconos INFO TXF   
sed -i "13c $frecuencia" /home/pi/INFO_RXF

SCRIPTS_version=$(awk "NR==3" /home/pi/version-fecha-actualizacion)
cd /home/pi/Desktop
sudo cp Abrir_YSF2DMR.desktop /home/pi
sed -i "4c Exec=sh -c 'cd /home/pi/$SCRIPTS_version/;sudo sh cerrar_YSF2DMR.sh'" /home/pi/Abrir_YSF2DMR.desktop
sed -i "5c Icon=/home/pi/$SCRIPTS_version/ICO_YSF2DMR_ON.png" /home/pi/Abrir_YSF2DMR.desktop
sed -i "10c Name[es_ES]=Cerrar YSF2DMR" /home/pi/Abrir_YSF2DMR.desktop
sed -i "14c YSF2DMR=ON" /home/pi/status.ini
cd /home/pi
sudo cp Abrir_YSF2DMR.desktop /home/pi/Desktop

sudo rm /home/pi/Abrir_YSF2DMR.desktop

cd /home/pi/YSF2DMR
xterm -geometry 88x6+1274+665 -bg brown -fg white -fa ‘verdana’ -fs 9x -T CONSOLA_YSFdmr -e ./YSF2DMR YSF2DMR.ini &  

sleep 2
cd /home/pi/MMDVMHost
#/home/pi/SYSTEM/./qt_info_ysf2dmr & sudo ./MMDVMFUSION MMDVMFUSION.ini
xterm -geometry 88x9+1274+787 -bg brown -fg white -fa ‘verdana’ -fs 9x -T CONSOLA_MMDVMFUSION -e sudo ./MMDVMFUSION MMDVMFUSION.ini

cd /home/pi/Desktop
sudo cp Abrir_YSF2DMR.desktop /home/pi
sed -i "4c Exec=sh -c 'cd /home/pi/$SCRIPTS_version/;sudo sh ejecutar_YSF2DMR.sh'" /home/pi/Abrir_YSF2DMR.desktop
sed -i "5c Icon=/home/pi/$SCRIPTS_version/ICO_YSF2DMR_OFF.png" /home/pi/Abrir_YSF2DMR.desktop
sed -i "10c Name[es_ES]=Abrir YSF2DMR" /home/pi/Abrir_YSF2DMR.desktop
sed -i "14c YSF2DMR=OFF" /home/pi/status.ini
cd /home/pi
sudo cp Abrir_YSF2DMR.desktop /home/pi/Desktop
sleep 1
sudo rm /home/pi/Abrir_YSF2DMR.desktop


