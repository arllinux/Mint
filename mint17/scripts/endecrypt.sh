#!/bin/bash

# endecrypt.sh
CWD=$(pwd)

param1=$1
param2='-chiffré'
param3='-déchiffré'
param4=$1$param2
param5=$1$param3
CH='-chiffré'
DCH='-dechiffré'

OPTION=$(whiptail --title "Menu Box" --menu "Que voulez-vous faire avec le fichier" 15 60 4 \
				"1" "Encrypter" \
				"2" "Décrypter"  3>&1 1>&2 2>&3)
 
exitstatus=$?
if [ $exitstatus = 0 ]; then
		if [ $OPTION = 1 ]; then
			openssl enc -e -aes-256-cbc -in $param1 -out $param4
		else
			if [ $OPTION = 2 ]; then
				openssl enc -d -aes-256-cbc -in $param1 -out $param5
			fi
		fi
	else
		echo "vous avez annulé"
fi

exit 0

# --\\\\\--
