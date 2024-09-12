#!/bin/bash
                    #cd /home/pi
                    #sudo cp -R MMDVMHost /home/pi/.local/ 
                    #sudo rm -r /home/pi/MMDVMHost
                    #sudo apt-get install build-essential git-core libi2c-dev i2c-tools lm-sensors
                    #git clone https://github.com/g4klx/MMDVMHost
                    #cd MMDVMHost
                    #git clone https://github.com/hallard/ArduiPi_OLED
                    #cd ArduiPi_OLED
                    #sudo make clean
                    #sudo make
                                    
                    cd /home/pi/MMDVMHost

                    HOY=$(date +%Y%m%d)
                    FIJA="const char* VERSION = "\"
                    PI="V106X"\"
                    HOY1=$HOY$PI
                    PUNTO=";"   
                    
                    sed -i "22c $FIJA$HOY1$PUNTO" /home/pi/MMDVMHost/Version.h

                    make clean
                    make -f Makefile.Pi.OLED

                    #Instala la secion [NextionDriver] en todos los .ini y todas sus memorias
                    #cd /home/pi/NextionDriverInstaller
                    #sudo ./NextionDriver_ConvertConfig /home/pi/MMDVMHost/MMDVM.ini
                    #sleep 2                  
                    
                    #sed -i "5c Duplex=0" /home/pi/MMDVMHost/MMDVM.ini
                    #sed -i "52c # UARTSpeed=460800" /home/pi/MMDVMHost/MMDVM.ini
                    #sed -i "229c Type=Direct" /home/pi/MMDVMHost/MMDVM.ini
                    #sed -i "231c # LocalPort=62032" /home/pi/MMDVMHost/MMDVM.ini
                    #sed -i "234c Password=PASSWORD" /home/pi/MMDVMHost/MMDVM.ini

                    # Crea los ejecutables para estas aplicaciones 
                    cd /home/pi/MMDVMHost
                    cp MMDVMHost MMDVMBM
                    cp MMDVMHost MMDVMPLUS
                    cp MMDVMHost MMDVMDSTAR
                    cp MMDVMHost MMDVMFUSION
                    cp MMDVMHost DMR2NXDN
                    cp MMDVMHost DMR2YSF
                    cp MMDVMHost MMDVMDMR2M17
                    cp MMDVMHost MMDVMNXDN
                    cp MMDVMHost MMDVMESPECIAL
                    cp MMDVMHost MMDVMDMRGATEWAY                 
                    
                    