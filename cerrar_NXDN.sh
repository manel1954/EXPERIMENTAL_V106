#!/bin/bash

sudo killall -9 NXDNGateway
sudo killall -9 MMDVMNXDN
SCRIPTS_version=$(awk "NR==3" /home/pi/version-fecha-actualizacion)
cd /home/pi/Desktop
sudo cp Abrir_NXDN.desktop /home/pi

sed -i "4c Exec=sh -c 'cd /home/pi/$SCRIPTS_version;sudo sh ejecutar_NXDN.sh'" /home/pi/Abrir_NXDN.desktop
sed -i "5c Icon=/home/pi/$SCRIPTS_version/ICO_NXDN_OFF.png" /home/pi/Abrir_NXDN.desktop
sed -i "10c Name[es_ES]=Abrir NXDN" /home/pi/Abrir_NXDN.desktop
sed -i "17c NXDN=OFF" /home/pi/status.ini

cd /home/pi
sudo cp Abrir_NXDN.desktop /home/pi/Desktop

sudo rm /home/pi/Abrir_NXDN.desktop

sudo killall -9 NXDNGateway
sudo killall -9 MMDVMNXDN
 
