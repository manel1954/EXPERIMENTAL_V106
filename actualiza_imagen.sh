#!/bin/bash

                        cd /home/pi/EXPERIMENTAL                       
                        git pull --force  
                        #cd /home/pi/A108/qt/
                        #./qt_popus_actualizada &                    
                        sudo rm -R /home/pi/A108
                        mkdir /home/pi/A108                                                
                        cp -R /home/pi/EXPERIMENTAL/* /home/pi/A108                                             
                        sudo chmod 777 -R /home/pi/A108
                                     
                        

                        
