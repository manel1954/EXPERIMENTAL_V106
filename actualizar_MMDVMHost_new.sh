#!/bin/bash
                    cd /home/pi/MMDVMHost


                    # Crea los ficheros .ini y Memorias ==================
                    cp MMDVMBM.ini MMDVMBM.ini_original
                    cp MMDVMBM.ini MMDVMBM.ini_copia
                    cp MMDVMBM.ini MMDVMBM.ini_copia2
                    cp MMDVMBM.ini MMDVMBM.ini_copia3

                    cp MMDVMBM.ini MMDVMBM.ini
                    cp MMDVMBM.ini MMDVMBM.ini_copia
                    cp MMDVMBM.ini MMDVMBM.ini_copia2
                    cp MMDVMBM.ini MMDVMBM.ini_copia3

                    cp MMDVMBM.ini MMDVMPLUS.ini
                    cp MMDVMBM.ini MMDVMPLUS.ini_copia
                    cp MMDVMBM.ini MMDVMPLUS.ini_copia2
                    cp MMDVMBM.ini MMDVMPLUS.ini_copia3

                    cp MMDVMBM.ini MMDVMDSTAR.ini
                    cp MMDVMBM.ini MMDVMDSTAR.ini_copia
                    cp MMDVMBM.ini MMDVMDSTAR.ini_copia2
                    cp MMDVMBM.ini MMDVMDSTAR.ini_copia3

                    cp MMDVMBM.ini MMDVMFUSION.ini
                    cp MMDVMBM.ini MMDVMFUSION.ini_copia
                    cp MMDVMBM.ini MMDVMFUSION.ini_copia2
                    cp MMDVMBM.ini MMDVMFUSION.ini_copia3  

                    cp MMDVMBM.ini MMDVMESPECIAL.ini
                    cp MMDVMBM.ini MMDVMESPECIAL.ini_copia
                    cp MMDVMBM.ini MMDVMESPECIAL.ini_copia2
                    cp MMDVMBM.ini MMDVMESPECIAL.ini_copia3                

                    cp MMDVMBM.ini MMDVMNXDN.ini
                    
                    cp MMDVMBM.ini TODOS_LOS_INIS.ini

                    cp MMDVMBM.ini MMDVMDMR2YSF.ini
                    
                    cp MMDVMBM.ini MMDVMDMR2NXDN.ini

                    cp MMDVMBM.ini MMDVMDMR2M17.ini
                  
                    cp MMDVMBM.ini MMDVMDMRGateway.ini 
                    
                    sed -i "52c UARTSpeed=115200" /home/pi/MMDVMHost/MMDVMDMRGateway.ini
                    sed -i "229c Type=Gateway" /home/pi/MMDVMHost/MMDVMDMRGateway.ini
                    sed -i "231c LocalPort=62032" /home/pi/MMDVMHost/MMDVMDMRGateway.ini
                    
                    sed -i "52c UARTSpeed=115200" /home/pi/MMDVMHost/MMDVMDMR2YSF.ini
                    sed -i "231c LocalPort=62032" /home/pi/MMDVMHost/MMDVMDMR2YSF.ini
                    sed -i "231c LocalPort=62032" /home/pi/MMDVMHost/MMDVMDMR2NXDN.ini
                    sed -i "231c LocalPort=62037" /home/pi/MMDVMHost/MMDVMDMR2M17.ini

                    sudo chmod 777 -R /home/pi/MMDVMHost
                
                    exit;
