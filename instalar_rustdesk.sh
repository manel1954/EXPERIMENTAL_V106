#!/bin/bash
clear
#Colores
ROJO="\033[1;31m"
VERDE="\033[1;32m"
BLANCO="\033[1;37m"
AMARILLO="\033[1;33m"
CIAN="\033[1;36m"
GRIS="\033[0m"
MARRON="\33[38;5;138m"
                        # Comprueba si Anydesk está instalado
                        estado_anydesk=$(awk "NR==65" /home/pi/status.ini)
                        if [ "$estado_anydesk" = 'RUSTDESK=ON' ];then
                        echo "\v\v\v\v\v\v"
                        echo "${ROJO}"
                        echo "***********************************************************************"
                        echo "***********************************************************************"
                        echo "                        RUSTDESK YA ESTÁ INSTALADO                     "
                        echo "                      NO PUEDES VOLVER A INSTALARLO                    "
                        echo "***********************************************************************"
                        echo "***********************************************************************"
                        sleep 4
                        else
                        echo "\v\v\v\v\v\v"
                        echo "${VERDE}"
                        echo "***********************************************************************"
                        echo "***********************************************************************"
                        echo "                         INSTALANDO RUSTDESK                            "
                        echo "***********************************************************************"
                        echo "***********************************************************************"
                        sleep 2  
                        cd /home/pi/Downloads
                        
                        wget https://github.com/rustdesk/rustdesk/releases/download/1.3.2/rustdesk-1.3.2-x86_64-sciter.deb
                        
                        sudo dpkg -i rustdesk-1.3.2-x86_64-sciter.deb
                                                
                        echo "\v\v\v\v\v\v"
                        echo "${VERDE}"
                        echo "***********************************************************************"
                        echo "***********************************************************************"
                        echo "                  SE HA INSTALADO RUSTDESK CON EXITO                   "
                        echo "***********************************************************************" 
                        echo "***********************************************************************"                      
                        sed -i "12c ANYDESK=ON" /home/pi/info.ini                        
                        sleep 3
                        #sudo reboot
                        fi
