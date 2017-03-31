#!/bin/bash
#
# installkdenlive.sh
# 
# Script par Jean-Pierre Antinoux - juin 2015

CWD=$(pwd)

# Vérification de la syntaxe de l'utilisateur principal
if [ $USER != "root" ]
    then
        echo "Pour exécuter ce script il faut être l'utilisateur root !"
    else
    # Vérification du nom d'utilisateur
    read -p 'Utilisateur (login) à personnaliser : ' nom
    while [ -z $nom ]; do
    echo "Veuillez saisir votre nom"
    read nom
    done
    cat /etc/passwd | grep bash | awk -F ":" '{print $1}' | grep -w $nom > /dev/null
        if [ $? = "0" ]
    then
    
    mkdir /usr/share/backgrounds/linuxmint-perso
    cd /usr/share/backgrounds/linuxmint-perso
    wget http://sloteur.free.fr/arllinux/fonds_arllinux.tar.gz
    tar xvzf fonds_arllinux.tar.gz
    rm fonds_arllinux.tar.gz
    chmod 0644 /usr/share/backgrounds/linuxmint-perso/*.jpg
    chown root:root /usr/share/backgrounds/linuxmint-perso/*.jpg
    cp $CWD/../wallpaper/linuxmint-perso.xml $WALXML

    # Installer les paquets supplémentaires
    PAQUETS=$(egrep -v '(^\#)|(^\s+$)' $CWD/../pkglists/paquets)
    apt-get --assume-yes install $PAQUETS
    
echo ":: Réglages de base terminés ::"
    else
       echo "Ce nom d'utilisateur n'existe pas. Réessayez !"
    fi
fi

exit 0
