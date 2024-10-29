sudo systemctl stop hblink
sudo systemctl stop hbmon
sudo systemctl stop parrot

sudo systemctl disable hblink
sudo systemctl disable hbmon
sudo systemctl disable parrot

sed -i "101c HBLINK=ON" /home/pi/status.ini