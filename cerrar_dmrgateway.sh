#!/bin/bash
sudo killall -9 MMDVMDMRGATEWAY
sudo killall -9 DMRGateway

SCRIPTS_version=$(awk "NR==3" /home/pi/version-fecha-actualizacion) 
cd /home/pi/Desktop
sudo cp Abrir_dmrgateway.desktop /home/pi/
sleep 1
sed -i "4c Exec=sh -c 'cd /home/pi/$SCRIPTS_version; sudo sh ejecutar_dmrgateway.sh'" /home/pi/Abrir_dmrgateway.desktop
sed -i "5c Icon=/home/pi/$SCRIPTS_version/ICO_DMRGATEWAY_OFF.png" /home/pi/Abrir_dmrgateway.desktop
sed -i "10c Name[es_ES]=Abrir DMRGateway" /home/pi/Abrir_dmrgateway.desktop
sed -i "19c DMRGateway=OFF" /home/pi/.local/status.ini
sleep 1
cd /home/pi/
sudo cp Abrir_dmrgateway.desktop /home/pi/Desktop
sleep 1
sudo rm /home/pi/Abrir_dmrgateway.desktop

sudo killall -9 MMDVMDMRGATEWAY
sudo killall -9 DMRGateway
