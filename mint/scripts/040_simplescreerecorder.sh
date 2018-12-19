#!/bin/bash

# 031_simplescreerecorder.sh
# JP Antinoux - mars 2018

if [ $USER != "root" ] ;
    then
      echo "Pour exécuter ce script il faut être l'utilisateur root !"
    else
    # Ajout du PPA, Mise à jour et installation
    add-apt-repository ppa:maarten-baert/simplescreenrecorder
    apt-get update
    apt-get install simplescreenrecorder
fi
