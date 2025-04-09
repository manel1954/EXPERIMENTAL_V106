#!/bin/bash

fecha=$(date +%Y%m%d) # extrae fecha del día en formato 20241129 
# Convertir a formato dd-mm-yyyy 29-11-2024
fecha_formateada=$(echo "$fecha" | awk '{print substr($0, 7, 2) "-" substr($0, 5, 2) "-" substr($0, 1, 4)}')
sed -i "2c $fecha_formateada" /home/pi/version-fecha-actualizacion

                        cd /home/pi/EXPERIMENTAL_V106                                              
                        git pull --force                      
                        sudo rm -R /home/pi/A108
                        mkdir /home/pi/A108                                                
                        cp -R /home/pi/EXPERIMENTAL_V106/* /home/pi/A108
                        sleep 6                                             
                        sudo chmod 777 -R /home/pi/A108
                        

                        
