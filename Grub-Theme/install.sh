#! /bin/bash
set -e

# This is original part
# Source code is here : 
# https://github.com/LegendaryBibo/Steam-Big-Picture-Grub-Theme
# ======================
#
# This script installs the GRUB2 theme in /boot/grub/themes/, /boot/grub2/themes/ or /grub/themes/
# depending on the distribution.
#
# Copyright (C) 2011 Towheed Mohammed
# who just started learning bash scripting, sed and regex's.
#
# This is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details at <http://www.gnu.org/licenses/>.
# ======================


# Traduction et adaptation Copyright (C) 2019 Jean-Pierre Antinoux
# ----------------------------------------------------------------
#
# Cette partie est l'adaptation de la source ci-dessus
# Le code source modifié est ici : 
# https://git.espritslibres.fr/sloteur/mint/src/master/Grub-Theme
# ======================
# Ce script installe un thème GRUB2 dans /boot/grub/themes/, /boot/grub2/themes/ ou /grub/themes
# en fonction des distributions.
# Copyright (C) 2011 Towheed Mohammed
# qui vient de commencer à apprendre les scripts bash, sed et regex's.
#
# Ceci un logiciel libre: vous pouvez le redistribuer et / ou modifier
# sous les termes de la licence publique générale GNU telle que publiée par
# la Free Software Foundation, soit la version 3 de la licence, soit
# (à votre choix) toute version ultérieure.

# Ce logiciel est distribué dans l’espoir qu’il vous sera utile,
# mais SANS AUCUNE GARANTIE; sans même la garantie implicite de
# QUALITÉ MARCHANDE ou ADAPTATION À UN USAGE PARTICULIER. Voir la
# Licence publique générale GNU pour plus de détails à <http://www.gnu.org/licenses/>.
# ======================

# Définition des variables
# Le thème sera installé dans un répertoire courant portant ce nom. Évitez les espaces.
Theme_Name="SteamBP"

# Fichier de définition du thème
Theme_Definition_File="theme.txt"

# Le thème a été conçu pour s'afficher au mieux avec 800x600,1024x768, etc,
# ou "any". pour n'importe quelle résolution (résolution indépendante)
Theme_Resolution="any"

Inst_Dir=$(dirname $0)

# Les répertoires doivent être dans cet ordre.
Grub_Dist_Dirs="/grub /boot/grub /boot/grub2"

# Ne pas changer cette ligne
let Grub_Min_Version=198

Grub_File="/etc/default/grub"
Grub_Dir=
mkConfig_File=
MVDIR="/boot/grub/themes/StreamBP/icons/"
=======
MVDIR="/boot/grub/themes/StreamBP/icons"
CWD=$(pwd)

#------------------------

# Vérifier que le script est bien lancé en root.
if [[ $(id -u) != 0 ]]; then
	echo "S'il vous plait, lancez ce script avec des privilèges root."
	exit 0
fi

# Récupérer le répertoire d'installation de GRUB
for i in $Grub_Dist_Dirs; do
	if [[ -d $i ]]; then
		Grub_Dir=$i
	fi
done

# Quitte le script si le répertoire de GRUB n'est pas trouvé.
if [[ -z $Grub_Dir ]]; then
	echo "Le répertoire d'installation de GRUB n'est pas présent."
	exit 0
fi

# Quitte le script si la version de GRUB < 1.98
if [[ -f $(which grub2-install) ]]; then
	Grub_Version_Long=$(grub2-install --version)
elif [[ -f $(which grub-install) ]]; then
	Grub_Version_Long=$(grub-install --version)
else
	echo "grub-install ou grub2 install ne sont pas présents dans votre path."
	echo "Le path est le chemin d'accès d'un fichier"
	exit 0
fi
Grub_Version=$(echo $Grub_Version_Long | sed 's,[[:alpha:][:punct:][:blank:]],,g')
if (( ${Grub_Version:0:3} < Grub_Min_Version )); then
	echo "GRUB doit être dans sa dernière version ${Grub_Min_Version:0:1}.${Grub_Min_Version:1:2}."
	echo "La version installée est ${Grub_Version:0:1}.${Grub_Version:1:2}."
	echo "Mettez Grub à jour et relancez le script" 
	exit 0
fi

# Vérifie si /etc/default/grub exists.
if [[ ! -f $Grub_File ]]; then
	echo "$Grub_File n'est pas présent."
	exit 0
fi

# Vérifie si le programme mkconfig existe.
mkConfig_File=$(which ${Grub_Dir##*/}-mkconfig) || \
(echo "La commande mkconfig de configation de Grub n'est pas présent dans vote path." && exit 0)

# Demande quelle résolution est désirée ou "any"
if [[ $Theme_Resolution = "any" ]]; then
	echo "============================================================================================"
	echo "Entrez la résolution désirée sous la forme : 1024x768, 800x600, 1600x1200, etc."
	echo "qui peut être trouvé en installant le paquet hwinfo et en exécutant hwinfo --framebuffer"
	echo ""
	echo "Les sorties sont variables. Vous pouvez essayer une résolution personnalisé comme 1920x1080,"
	echo "mais il n'y a pas de garantie que celle-ci fonctionne."
	echo ""
	echo "La résolution 1680x1050 fonctionne bien sur un écran de même taille."
	echo ""
	echo "Si vous voulez arrêter le script : tapez Ctrl + c"
	echo "============================================================================================"
	echo -n "Entrez la résolution que vous désirée [AAAAxBBBB : "
	read Theme_Resolution
fi

# Crée le répertoire du thème. Si le répertoire existe, demande ce qu'il faut faire,
# soit créer un nouveau répertoire soit écraser le contenu.
Theme_Dir=$Grub_Dir/themes/$Theme_Name
while [[ -d $Theme_Dir ]]; do
	echo "Le répertoire $Theme_Dir existe déja !"
	echo -n "Voulez-vous remplacer le contenu de celui-ci ou créer un nouveau répertoire ? [(r)emplacer (c)réer] "
	read Response
	case $Response in
		c|créer)
			echo -n "Entrez un nouveau nom pour le répertoire du thème :"
			read Response
			Theme_Dir=$Grub_Dir/themes/$Response;;
		r|emplacer)
			echo -n "Ceci va supprimer tous les fichiers dans $Theme_Dir. Etes-vous sûr ? [(o)ui (n)on] "
			read Response
			case $Response in
				o|oui)
					rm -r $Theme_Dir;;
				*)
					exit 0;;
			esac;;
		*)
			exit 0;;	
	esac
done
mkdir -p $Theme_Dir

# Copie les fichiers du thème vers le répertoire d'installation du thème.
for i in $Inst_Dir/*; do
	cp -r $i $Theme_Dir/$(basename $i)
done
echo "Les fichiers ont été copiés dans le dossier $Theme_Dir"

# Linux Mint a bien une icône mais comme dans grub Linux Mint s'appelle "Ubuntu"
# Modifier le nom de l'icône et supprimer "Ubuntu" original.
echo "Vous utilisez une distribution Linux Mint ? : [(o)ui (n)on] "
read mint
if [[ $mint = oui || $mint = o ]]; then
	cd $MVDIR
	rm $CWD/ubuntu.png
	mv $CWD/linuxmint.png $CWD/ubuntu.png
fi

# Vérifier si un répertoire d'icônes existe. Si des icônes ne sont pas incluses dans ce thème
# vérifier s'il en existe dans ..../themes/icons.
# S'il y en a, demander à l'utilisateur s'il veut les utiliser.
if [[ ! -d $Theme_Dir/icons && -d $Grub_Dir/themes/icons ]]; then
	echo "Il n'y a pas de répertoire d'icônes dans ce thème."
	echo "Toutefois, on peut en trouver dans  $Grub_Dir/themes/icons qui contient ce type de fichier"
	echo $(ls $Grub_Dir/themes/icons)
	echo -n "Voulez-vous utiliser ces icônes [(o)ui (n)on] "
	read Response
	case $Response in
		o|oui)
			ln -s $Grub_Dir/themes/icons $Theme_Dir/;;
		*)
			echo "Ce thème n'affiche pas d'icônes.";;
	esac
elif [[ ! $Theme_Dir/icons && ! -d $Grub_Dir/themes/icons ]]; then
	echo "Aucun répertoire d'icônes n'a été trouvé. Ce thème ne peut afficher les icônes."
fi

# Linux Mint a bien une icône mais comme dans grub Linux Mint s'appelle "Ubuntu"
# Modifier le nom de l'icône et supprimer "Ubuntu" original.
# echo "Vous utilisez une distribution Linux Mint ? : [(o)ui (n)on] "
# read mint
# if [[ $mint = oui || $mint = o ]]; then
# 	cd $MVDIR
# 	rm $CWD/ubuntu.png
# 	mv $CWD/linuxmint.png $CWD/ubuntu.png
# fi

# Changer la résolution de GRUB pour qu'elle s'adapte à ce thème.
if [[ $Theme_Resolution != "any" ]]; then
	i=$(sed -n 's,^#\?GRUB_GFXMODE=,&,p' $Grub_File)
	if [[ -z $i ]]; then
		echo -e "\nGRUB_GFXMODE=$Theme_Resolution" >>$Grub_File
	else
		sed "s,^#\?GRUB_GFXMODE=.*,GRUB_GFXMODE=$Theme_Resolution," <$Grub_File >$Grub_File.~
		mv $Grub_File.~ $Grub_File
	fi
fi

# Demander à l'utilisateur s'il veut appliquer le nouveau thème.
echo -n "Voulez-vous définir ceci comme votre nouveau thème ? [o)ui (n)on] "
read Response
if [[ $Response = oui || $Response = o ]]; then
	i=$(sed -n 's,^#\?GRUB_THEME=,&,p' $Grub_File)
	if [[ -z $i ]]; then
		echo -e "\nGRUB_THEME=$Theme_Dir/$Theme_Definition_File" >>$Grub_File
	else
		sed "s,^#\?GRUB_THEME=.*,GRUB_THEME=$Theme_Dir/$Theme_Definition_File," <$Grub_File >$Grub_File.~
		mv $Grub_File.~ $Grub_File
	fi	
	$($mkConfig_File -o $Grub_Dir/grub.cfg)	# Génère un nouveau grub.cfg
fi
exit 0
