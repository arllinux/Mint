#!/bin/bash

# endecrypt.sh

# Ce script permet de crypter un fichier avec un mot de passe en AES-256
# Ce codage est actuellement le plus utilisé et le plus sûr.
# Il faut ouvrir un terminal et se déplacer dans le répertoire où se trouve le
# script "endecrypt.sh".
# Pour crypter une fichier que vous aurez placé OBLIGATOIREMENT sur votre
# Bureau il faut simplement taper : ./endecrypt nom_du_fichier.
# Pour décrypter il faire la mème opétation en choisissan l'option "décrypter".

# Jean-Pierre Antinoux - Mars 2017

param1=$1												# Récupère le nom du fichier
param2='-chiffré' 							# Cette variable contient la chaine de caractères "-chiffré"
param3=$1$param2								# Regroupe les variables param1 & param2
																# = nom_du_fichier+chiffré 
nomfichier=${param1%-*é}				# Efface à la fin du nom du fichier depuis le -
																# vers caractère "é". Efface donc le mot "-chiffré"

# Affiche la fenêtre qui propose le choix
OPTION=$(whiptail --title "Menu Box" --menu "Que voulez-vous faire avec le fichier" 15 60 4 \
				"1" "Encrypter" \
				"2" "Décrypter"  3>&1 1>&2 2>&3)
 
exitstatus=$?
if [ $exitstatus = 0 ]; then
		# Si on choisi l'option 1 le fichier est encrypté
		if [ $OPTION = 1 ]; then
			openssl enc -e -aes-256-cbc -in /home/$USER/Bureau/$param1 -out $param3
		else
			# Si on choisi l'option 2 le fichier est décrypté sur le Bureau
			if [ $OPTION = 2 ]; then
				openssl enc -d -aes-256-cbc -in $param1 -out $nomfichier
				mv $nomfichier /home/$USER/Bureau/
			fi
		fi
	else
		echo "vous avez annulé"
fi

exit 0

# --\\\\\--
