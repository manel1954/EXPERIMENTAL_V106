#!/bin/bash


# SCRIPTS_version=$(awk "NR==3" /home/pi/version-fecha-actualizacion)
# cd /home/pi/Desktop
# sudo cp Abrir_svxlink.desktop /home/pi
# sed -i "4c Exec=sh -c 'cd /home/pi/$SCRIPTS_version;sudo sh cerrar_svxlink.sh'" /home/pi/Abrir_svxlink.desktop
# sed -i "5c Icon=/home/pi/$SCRIPTS_version/ICO_SVXLINK_ON.png" /home/pi/Abrir_svxlink.desktop
# sed -i "10c Name[es_ES]=Cerrar SVXLINK" /home/pi/Abrir_svxlink.desktop
sed -i "8c SVXLINK=ON" /home/pi/status.ini
# cd /home/pi
# sudo cp Abrir_svxlink.desktop /home/pi/Desktop

# sudo rm /home/pi/Abrir_svxlink.desktop




xterm -geometry 88x17+1285+745 -bg black -fg cyan -fa 'serift' -fs 9x -T CONSOLA_SVXLINK -e sudo svxlink


# cd /home/pi/Desktop
# sudo cp Abrir_svxlink.desktop /home/pi
# sed -i "4c Exec=sh -c 'cd /home/pi/$SCRIPTS_version;sudo sh ejecutar_svxlink.sh'" /home/pi/Abrir_svxlink.desktop
# sed -i "5c Icon=/home/pi/$SCRIPTS_version/ICO_SVXLINK_OFF.png" /home/pi/Abrir_svxlink.desktop
# sed -i "10c Name[es_ES]=Abrir SVXLINK" /home/pi/Abrir_svxlink.desktop
# sed -i "8c SVXLINK=OFF" /home/pi/status.ini
# cd /home/pi
# sudo cp Abrir_svxlink.desktop /home/pi/Desktop

# sudo rm /home/pi/Abrir_svxlink.desktop