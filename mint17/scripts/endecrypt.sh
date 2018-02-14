#!/bin/bash

# endecrypt.sh
# Ce script permet de crypter un fichier avec un mot de passe en AES-256
# Ce codage est actuellement le plus utilisé et le plus sûr.

# Il faut ouvrir un terminal et se déplacer dans le répertoire où se trouve le
# script "endecrypt.sh".

# Pour crypter une fichier que vous aurez placé OBLIGATOIREMENT sur votre
# Bureau il faut simplement taper : ./endecrypt nom_du_fichier.

# Pour décrypter il faire la même opération en choisissant l'option "décrypter".
# Le script fait appel au programme "whiptail" qui permet selon sa description de :
# Displays user-friendly dialog boxes from shell scripts
# Pour l'installer : apt-get install whiptail
# Jean-Pierre Antinoux - Mars 2017
# Ajout  ==> Février 2018, à chaque encryptage suppression du fichier sur le bureau.

##################################################
# Ne pas mettre d'espaces dans le nom du fichier #
##################################################

param1=$1                   # Récupère le nom du fichier
param2='-chiffré'           # Cette variable contient la chaine de caractères "-chiffré"
param3=$1$param2            # Regroupe les variables param1 & param2
                            # = nom_du_fichier+chiffré 
nomfichier=${param1%-*é}    # Efface à la fin du nom du fichier depuis le -
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
				rm /home/$USER/Bureau/$1
		else
			# Si on choisi l'option 2 le fichier est décrypté sur le Bureau
			if [ $OPTION = 2 ]; then
				openssl enc -d -aes-256-cbc -in $param1 -out $nomfichier
				mv $nomfichier /home/$USER/Bureau/
			fi
		fi
	else
		echo "Vous avez annulé la procédure"
fi

exit 0

# --\\\\\--
