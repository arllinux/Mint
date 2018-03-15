#!/bin/bash

# Vérification de la syntaxe de l'utilisateur principal
if [ $USER != "root" ]
   then
       echo "Pour exécuter ce script il faut être l'utilisateur root !"
   else
    # Vérification du nom d'utilisateur
    read -p 'Utilisateur (login) dans lequel installer le répertoire : ' nom
    while [ -z $nom ]; do
    echo "Veuillez saisir votre nom"
    read nom
    done
    cat /etc/passwd | grep bash | gawk -F ":" '{print $1}' | grep -w $nom > /dev/null
        if [ $? = "0" ]
         then
         if [ -z $(which ffmpeg) ];
								 then
								 apt-get --assume-yes install ffmpeg
				 fi
        fi
         echo "========================================="
				 echo "== Mise en place du dossier de travail =="
				 echo "==  dans votre répertoirer personnel   =="
         echo "========================================="
         cp -R joindre_videos/ /home/$nom/Vidéos/
         chown -R $nom:$nom /home/$nom/Vidéos/joindre_videos
fi
