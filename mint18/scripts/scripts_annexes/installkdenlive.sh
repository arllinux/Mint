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
    cat /etc/passwd | grep bash | gawk -F ":" '{print $1}' | grep -w $nom > /dev/null
        if [ $? = "0" ]
    then

		# Installation des programmes				
				read -p 'Voulez-vous installer kdenlive et la traduction française ?
				(oui/non) : ' oui
		if [ $oui = "oui" ]
				then
   
		# Installer les paquets supplémentaires
    KDENLIVE=$(egrep -v '(^\#)|(^\s+$)' $CWD/../pkglists/kdenlive)
    apt-get --assume-yes install $KDENLIVE
		fi
		# Installer le fichier de configuration personnelle
		if [ $oui = "oui" ]
				then
    		cd /home/$nom/.config/
    		wget http://sloteur.free.fr/arllinux/kdenliverc.tar.gz
    		tar xvzf kdenliverc.tar.gz
    		rm kdenliverc.tar.gz
    		chown $nom:$nom /home/$nom/.config/kdenliverc
		fi
echo ":: Réglages de base terminés. Il faut redéfinir les raccourcis clavier ::"
    else
       echo "Ce nom d'utilisateur n'existe pas. Réessayez !"
    fi
fi

exit 0
