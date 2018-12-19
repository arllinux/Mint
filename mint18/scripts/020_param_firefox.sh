#!/bin/bash
#
# param_firefox.sh
# 
# script original (c) Niki Kovacs, 2014
# Adapté par Jean-Pierre Antinoux - juin 2014

CWD=$(pwd)
SLO10rc='http://sloteur.free.fr/arllinux/nutyx10rc_0118'
MOZ='pref-firefox-63.tar.gz'

# Vérification de la syntaxe de l'utilisateur principal
    # Vérification du nom d'utilisateur
    read -p 'Utilisateur (login) à personnaliser : ' nom
    while [ -z $nom ]; do
    echo "Veuillez saisir votre nom"
    read nom
    done
    cat /etc/passwd | grep bash | gawk -F ":" '{print $1}' | grep -w $nom > /dev/null
		 if [ $? = "0" ]
        then
         cd /home/$nom
         wget $SLO10rc/$MOZ
         tar xvf $MOZ
         rm $MOZ
         chown -R $nom:$nom /home/$nom/.mozilla
     else
      echo "Ce nom d'utilisateur n'existe pas. Réessayez !"
   fi
exit 0
