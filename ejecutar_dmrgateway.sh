#!/bin/bash

sudo systemctl stop mmdvm_bridge.service #esto se hace para que funcione el DMRGateway 

mode=`grep -n -m 1 "^Port=" /home/pi/MMDVMHost/MMDVMDMRGateway.ini`
buscar=":"
caracteres=`expr index $mode $buscar`
caracteres_linea=`expr $caracteres - 1`
numero_linea_port=`expr substr $mode 1 $caracteres_linea`
mode=$(awk "NR==$numero_linea_port" /home/pi/MMDVMHost/MMDVMDMRGateway.ini)
puerto=`expr substr $mode 11 9`
puerto="  "$puerto
cd /home/pi/Desktop
cp RXF_DMRGATEWAY.desktop /home/pi

frecuencia=$(awk "NR==13" /home/pi/MMDVMHost/MMDVMDMRGateway.ini)
frecuencia=`expr substr $frecuencia 13 17`
frecuencia=$frecuencia$puerto
sed -i "11c Name=$frecuencia" /home/pi/RXF_DMRGATEWAY.desktop

cp /home/pi/RXF_DMRGATEWAY.desktop /home/pi/Desktop

sudo rm /home/pi/RXF_DMRGATEWAY.desktop
#Escribe en el fichero INFO_RXF para poner los datos en el icono INFO TXF                         
sed -i "18c $frecuencia" /home/pi/INFO_RXF

SCRIPTS_version=$(awk "NR==3" /home/pi/version-fecha-actualizacion)
#Colores
ROJO="\033[1;31m"
VERDE="\033[1;32m"
BLANCO="\033[1;37m"
AMARILLO="\033[1;33m"
CIAN="\033[1;36m"
GRIS="\033[0m"
cd /home/pi/Desktop
cp Abrir_dmrgateway.desktop /home/pi/
#sleep 1
sed -i "4c Exec=sh -c 'cd /home/pi/$SCRIPTS_version; sudo sh cerrar_dmrgateway.sh'" /home/pi/Abrir_dmrgateway.desktop
sed -i "5c Icon=/home/pi/$SCRIPTS_version/ICO_DMRGATEWAY_ON.png" /home/pi/Abrir_dmrgateway.desktop
sed -i "10c Name[es_ES]=Cerrar DMRGateway" /home/pi/Abrir_dmrgateway.desktop
sed -i "19c DMRGateway=ON" /home/pi/status.ini
#sleep 1
cd /home/pi/
cp Abrir_dmrgateway.desktop /home/pi/Desktop
#sleep 1
sudo rm /home/pi/Abrir_dmrgateway.desktop
#zenity --warning --ok-label=CERRAR --title=DMRGateway --window-icon=/home/pi/SYSTEM/ICONO_DMRGATEWAY_ON.png --width=500 --timeout=15 --text "\nTG 6 Para hablar por XLX\nTG 8 Para hablar por DMR+\nTG 10 para hablar por TGIF\nTG 11 Para hablar por HBLINK\nPara hablar por BM cualquier TG menos (8, 6, 10 y 11)\n\nALERTA!! BM y DMR+, no son compatibles con DVSWITCH"

#home/pi/SYSTEM/./aviso_tgs_dmrgateway
echo "${VERDE}"
echo "************************************************************************"
echo "*                       Abriendo DMRGateway                            *"
echo "************************************************************************"

sleep 2

echo "${GRIS}"

cd /home/pi/DMRGateway

xterm -geometry 88x18+648+357 -bg white -fg black -fa ‘verdana’ -fs 9x -T CONSOLA_DMRGateway -e sudo ./DMRGateway DMRGateway.ini &

sleep 2

cd /home/pi/MMDVMHost
xterm -geometry 88x16+648+665 -bg white -fg black -fa ‘verdana’ -fs 9x -T CONSOLA_MMDVMDMRGATEWAY -e sudo ./MMDVMDMRGATEWAY MMDVMDMRGateway.ini 


# Cierra el icono ejecutar_dmrgateway si no hay conexión
cd /home/pi/Desktop
sudo cp Abrir_dmrgateway.desktop /home/pi/
sleep 1
sed -i "4c Exec=sh -c 'cd /home/pi/$SCRIPTS_version; sudo sh ejecutar_dmrgateway.sh'" /home/pi/Abrir_dmrgateway.desktop
sed -i "5c Icon=/home/pi/$SCRIPTS_version/ICO_DMRGATEWAY_OFF.png" /home/pi/Abrir_dmrgateway.desktop
sed -i "10c Name[es_ES]=Abrir DMRGateway" /home/pi/Abrir_dmrgateway.desktop
sed -i "19c DMRGateway=OFF" /home/pi/status.ini
sleep 1
cd /home/pi/
cp Abrir_dmrgateway.desktop /home/pi/Desktop
sleep 1
sudo rm /home/pi/Abrir_dmrgateway.desktop




