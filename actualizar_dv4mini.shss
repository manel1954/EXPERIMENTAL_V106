#!/bin/bash
clear
while true
do
SCRIPTS_version=$(awk "NR==3" /home/pi/version-fecha-actualizacion)
#Colores
ROJO="\033[1;31m"
VERDE="\033[1;32m"
BLANCO="\033[1;37m"
AMARILLO="\033[1;33m"
CIAN="\033[1;36m"
GRIS="\033[0m"
MARRON="\33[38;5;138m"
echo "${VERDE}"         
echo "   **************************************************************************"
echo "   *                                                                        *"
echo "   *                   Script para Actualizar DV4MINI                       *" 
echo -n "${ROJO}"   
echo "  ${VERDE} * ${ROJO}                            by EA3EIZ ${VERDE}                                 *"
echo -n "${VERDE}" 
echo "   *                                                                        *"
echo "   **************************************************************************"
echo ""
echo  "\33[1;36m   1)${BLANCO} Actualizar para utilizar \33[1;32mDV4MINI 20200303${AMARILLO} (NEW)   \33[1;33m"
echo  "\33[1;36m   2)${BLANCO} Actualizar para utilizar \33[1;32mDV4MINI 20170517   \33[1;33m"

echo ""
echo -n "\33[1;36m   Elige una opción: " 
read escoger_menu
case $escoger_menu in

1) echo ""
while true
do
clear
                        ejecutar1=S
                        case $ejecutar1 in
                        [sS]* ) echo ""
                        echo "<<<<<<<< ACTUALIZANDO DV4MINI >>>>>>>>>"
                        sudo rm -r /home/pi/SYSTEM/DV4MINI/
                        cd /home/pi/SYSTEM
                        git clone http://github.com/ea3eiz/DV4MINI
                        sudo rm -r /home/pi/dv4mini
                        sudo rm /usr/bin/dv_serial
                        sudo mkdir /home/pi/dv4mini
                        sudo chmod 777 -R /home/pi/dv4mini
                        cd /home/pi/SYSTEM/DV4MINI/20200303
                        sudo cp dv_serial /home/pi/dv4mini
                        sudo cp dv4mini.exe /home/pi/dv4mini
                        sudo cp xref.ip /home/pi/dv4mini
                        sudo cp dv_serial /usr/bin/
                        cd /usr/bin/
                        sudo chmod 777 dv_serial
                        cd /home/pi/dv4mini
                        sudo chmod 777 dv_serial
                        clear
                        echo "************************************"
                        echo "*** SE HA ACTUALIZADO CON EXITO  ***"
                        echo "************************************"
                        sleep 3                        
                        clear
                        break;;
                        [nN]* ) echo ""
                        break;;
esac
done;;
2) echo ""
while true
do
clear
                        ejecutar1=S
                        case $ejecutar1 in
                        [sS]* ) echo ""
                        echo ">>>>>>>>> ACTUALIZANDO >>>>>>>>"
                        sudo rm -r /home/pi/SYSTEM/DV4MINI/
                        cd /home/pi/SYSTEM
                        git clone http://github.com/ea3eiz/DV4MINI
                        sudo rm -r /home/pi/dv4mini
                        sudo rm /usr/bin/dv_serial
                        sudo mkdir /home/pi/dv4mini
                        sudo chmod 777 -R /home/pi/dv4mini
                        cd /home/pi/SYSTEM/DV4MINI/20170517
                        cp dv_serial /home/pi/dv4mini
                        cp dv4mini.exe /home/pi/dv4mini
                        cp xref.ip /home/pi/dv4mini
                        sudo cp dv_serial /usr/bin/
                        cd /usr/bin/
                        sudo chmod 777 dv_serial
                        cd /home/pi/dv4mini
                        sudo chmod 777 dv_serial
                        clear
                        echo "************************************"
                        echo "*** SE HA ACTUALIZADO CON EXITO  ***"
                        echo "************************************"
                        sleep 3                        
                        clear
                        break;;
                        [nN]* ) echo ""
                        break;;
esac
done;;
3) echo ""
while true
do
clear
                        ejecutar1=S
                        case $ejecutar1 in
                        [sS]* ) echo ""
sh reinstalar_hblink.sh
                        break;;
                        [nN]* ) echo ""
                        break;;
esac
done;;
0) echo ""
clear
echo "\33[1;33m   ******************************"
echo "   *                            *"
echo "   *     CERRANDO SCRIPT        *"
echo "   *                            *"
echo "   ******************************"
sleep 1
clear
exit;;	
esac
done

