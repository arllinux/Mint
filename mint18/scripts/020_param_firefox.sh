#!/bin/bash
#
# param_firefox.sh
# 
# script original (c) Niki Kovacs, 2014
# Adapté par Jean-Pierre Antinoux - juin 2014

CWD=$(pwd)

# Vérification de la syntaxe de l'utilisateur principal
    # Vérification du nom d'utilisateur
    read -p 'Utilisateur (login) à personnaliser : ' nom
    while [ -z $nom ]; do
    echo "Veuillez saisir votre nom"
    read nom
    done
    cat /etc/passwd | grep bash | awk -F ":" '{print $1}' | grep -w $nom > /dev/null
        if [ $? = "0" ]
        then
				cd /home/$nom
				wget http://sloteur.free.fr/param_mf/mozilla.tar.gz
				tar xvf mozilla.tar.gz
				rm mozilla.tar.gz
				chown -R $nom:$nom /home/$nom/.mozilla
    else
       echo "Ce nom d'utilisateur n'existe pas. Réessayez !"
    fi
exit 0
