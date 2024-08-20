#!/bin/bash
#Colores
ROJO="\033[1;31m"
VERDE="\033[1;32m"
BLANCO="\033[1;37m"
AMARILLO="\033[1;33m"
CIAN="\033[1;36m"
GRIS="\033[0m"
MARRON="\33[38;5;138m"
NEGRO="\33[0;30m"
clear
echo ""
echo -n "${AMARILLO}"
echo "    *******ACTUALIZANDO IDS INDICATIVOS**25-01-2023"
echo -n "${VERDE}"
#echo "ACTUALIZANDO DMRIds.dat para DVSWITCH"
sleep 13
echo "${NEGRO}"
var=`grep -n -m 1 '\<DMRIDPATH\>' /home/pi/MMDVMHost/linux/DMRIDUpdate.sh`
buscar=":"
largo_linea=`expr index $var $buscar`
largo_linea=`expr $largo_linea - 1`
numero_linea=`expr substr $var 1 $largo_linea`
letrac=c
linea_sed=$numero_linea$letrac
sed -i "$linea_sed DMRIDPATH=/home/pi/MMDVMHost" /home/pi/MMDVMHost/linux/DMRIDUpdate.sh

# DMR IDs now served by RadioID.net
var=`grep -n -m 1 '\<DATABASEURL\>' /home/pi/MMDVMHost/linux/DMRIDUpdate.sh`
buscar=":"
largo_linea=`expr index $var $buscar`
largo_linea=`expr $largo_linea - 1`
numero_linea=`expr substr $var 1 $largo_linea`
letrac=c
linea_sed=$numero_linea$letrac
sed -i "$linea_sed DATABASEURL='https://ham-digital.org/status/users.csv'" /home/pi/MMDVMHost/linux/DMRIDUpdate.sh

sudo sh /home/pi/MMDVMHost/linux/DMRIDUpdate.sh


                        # 14-08-2020 cambio actualizar para que salgan los indicativos en DVSWITCH:
                        cd /var/lib/mmdvm
                        sudo curl --fail -o DMRIds.dat -s http://www.pistar.uk/downloads/DMRIds.dat
                        sudo chmod 777 -R /var/lib/mmdvm

                        cp DMRIds.dat /home/pi/DMR2YSF/
                        #sudo curl --fail -o DMRIds.dat -s http://www.pistar.uk/downloads/DMRIds.dat

                        cp DMRIds.dat /home/pi/YSF2DMR/
