#!/bin/bash

sudo apt install deborphan
sudo apt-get purge ${deborphan}
sudo apt autoclean
sudo apt clean
sudo apt autoremove
sudo dpkg -l | grep ^rc | awk '{print $2}' | xargs sudo dpkg -P

