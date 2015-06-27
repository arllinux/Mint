#!/bin/bash
#
# param_cairo.sh
# 
# Jean-Pierre Antinoux - avril 2015

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
				cd /home/$nom/.config/
				wget http://sloteur.free.fr/arllinux/cairo-dock-jp.tar.gz
				tar xvf cairo-dock-jp.tar.gz
				rm cairo-dock-jp.tar.gz
				chown -R $nom:$nom /home/$nom/.config/cairo-dock
    else
       echo "Ce nom d'utilisateur n'existe pas. Réessayez !"
    fi
exit 0
