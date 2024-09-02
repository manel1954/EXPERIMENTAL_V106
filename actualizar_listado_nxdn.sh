#!/bin/bash
clear
usuario=$(awk "NR==1" /home/pi/.config/autostart/usuario)
SCRIPTS_version=$(awk "NR==3" $usuario/version-fecha-actualizacion)                                                                       
#Colores 
ROJO="\033[1;31m"
VERDE="\033[1;32m"
BLANCO="\033[1;37m"
AMARILLO="\033[1;33m"
CIAN="\033[1;36m"
GRIS="\033[0m"
MARRON="\33[38;5;138m"
echo "\v\v"
echo "${VERDE}"
echo "            ********************************************************"
echo "${BLANCO}"
echo "                       ACTUALIZANDO FICHERO NXDNHost.txt"
echo "${VERDE}"
echo "            ********************************************************"
                
cd $usuario/NXDNClients/NXDNGateway/
sudo rm -R private
mkdir private
cd $usuario/$SCRIPTS_version
cp NXDNHosts.txt $usuario/NXDNClients/NXDNGateway/private
cp NXDNHosts.txt $usuario/NXDNClients/NXDNGateway                            
sleep 2
clear  
echo "\v\v"  
echo "${VERDE}"
echo "            ********************************************************"
echo "${AMARILLO}"
echo "                    SE HA ACTUALIZADO EL FICHERO NXDNHost.txt"
echo "${VERDE}"
echo "            ********************************************************"
sleep 4  
exit	

