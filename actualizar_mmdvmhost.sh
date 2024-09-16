#!/bin/bash
                    cd /home/pi/MMDVMHost

                    HOY=$(date +%Y%m%d)
                    FIJA="const char* VERSION = "\"
                    PI="A108EXP"\"
                    HOY1=$HOY$PI
                    PUNTO=";"   
                    
                    sed -i "22c $FIJA$HOY1$PUNTO" /home/pi/MMDVMHost/Version.h

                    make clean
                    make
