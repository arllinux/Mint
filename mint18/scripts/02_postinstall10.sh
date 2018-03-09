#!/bin/bash
#
# 02_postInstall10.sh
# Jean-Pierre Antinoux - Janvier 2018

# Ce script permet d'automatiser la post install de la NuTyx 10.0
# Il ajoute les outils que je trouve nécessaires, ajuste le fichier network
# (obsolète) propose 2 installations d'outils pour un poste de travail

# Jean-Pierre Antinoux - Janvier 2018 - Février 2018
# Ajout d'une liste de choix pour les logiciels plutôt que 2 packs
# préconfigurés.
# 2 mars 2018
# Précision sur le chemin des fichiers firefox, clementine, listechoix avec
# l'introdution de l'emplacement pour l'effacement et la suppression à la fin
# du script.

CWD=$(pwd)
APPWAY="/usr/share/applications"

# Vérification de la syntaxe de l'utilisateur principal
 if [ $USER != "root" ]
    then
      echo "Pour exécuter ce script il faut être l'utilisateur root !"
 else
 
 	 # Mettre en place le fichier de conf adapté pour NetworkManagerœ
    echo "Fichier de conf du network manager"
    cp $CWD/../network/network /etc/sysconfig/network

   # Propose un choix de paquets et permet d'en sélectionner de nouveaux - Février
   # Vérifie si les fichiers cités existent et les supprime. 
	  if [ -f "firefox" ];then
	    rm $CWD/firefox
    fi
    if [ -f "clementine" ];then
	    rm $CWD/clementine
    fi
    if [ -f "listechoix" ];then
      rm $CWD/listechoix
    fi
    touch $CWD/listechoix

		# Liste de choix
    cmd=(dialog --separate-output --checklist "Sélectionner ou désélectionner avec la barre d'espace :" 22 76 16)
    # any option can be set to default to "on" or "off"
    options=(1 "libreoffice" on
             2 "firefox" on
             3 "brasero" on
             4 "vlc" on
             5 "clementine" on
             6 "gimp" on
             7 "simple-scan" off
             8 "simplescreenrecorder" off
             9 "abiword" off
            10 "gnumeric" off
            11 "midori" off
            12 "claws-mail" off
            13 "thunderbird" off
            14 "transmission" on
            15 "filezilla" on
            16 "mypaint" off
            17 "shotwell" off
            18 "inkscape" off
            19 "darktable" off
            20 "blender" off
            21 "geany" off)
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
    for choice in $choices
    do
        case $choice in
            1)
                echo "libreoffice" >> listechoix
                ;;
            2)
                echo "firefox" >> listechoix > firefox
                ;;
            3)
                echo "brasero" >> listechoix
                ;;
            4)
                echo "vlc" >> listechoix
                ;;
            5)
                echo "clementine" >> listechoix > clementine
                ;;
            6)
                echo "gimp" >> listechoix
                ;;
            7)
                echo "simple-scan" >> listechoix
                ;;
            8)
                echo "simplescreenrecorder" >> listechoix
                ;;
            9)
                echo "abiword" >> listechoix
                ;;
            10)
                echo "gnumeric" >> listechoix
                ;;
            11)
                echo "midori" >> listechoix
                ;;
            12)
                echo "claws-mail" >> listechoix
                ;;
            13)
                echo "thunderbird" >> listechoix
                ;;
            14)
                echo "transmission" >> listechoix
                ;;
            15)
                echo "filezilla" >> listechoix
                ;;
            16)
                echo "mypaint" >> listechoix
                ;;
            17)
                echo "shotwell" >> listechoix
                ;;
            18)
                echo "inkscape" >> listechoix
                ;;
            19)
                echo "darktable" >> listechoix
                ;;
            20)
                echo "blender" >> listechoix
                ;;
            21)
                echo "geany" >> listechoix
                ;;
        esac
    done
    if [ $? = "0" ]
       then
       # Ajouter les paquets sélectionnés ci-dessus
       echo "==============================================================="
       echo "==                     Ajout de paquets                      =="
       echo "==============================================================="
       PAQUETSAJ=$(egrep -v '(^\#)|(^\s+$)' $CWD/listechoix)
       cards install $PAQUETSAJ

			 # Firefox ne s'installe pas correctement et il faut forcer l'install.
  		 if [ -f "firefox" ];then
       	cards install firefox -f
			 fi

			 # Supprimer les paquets non désirés
       echo "==============================================================="
       echo "==                  Suppression de paquets                   =="
       echo "==============================================================="
       PAQUETSSUPP=$(egrep -v '(^\#)|(^\s+$)' $CWD/../pkglists/sup_paquets)
       cards remove $PAQUETSSUPP
  
       # Mise à jour de fichiers .desktop traduits partiellement
       echo "==============================================================="
       echo "==             Remplacemnt de fichiers .desktop              =="
       echo "==============================================================="
  		 if [ -f "$CWD/firefox" ];then
         cp $APPWAY/firefox.desktop $APPWAY/firefox.desktop.old
         cp $CWD/../desktop/firefox.desktop $APPWAY/firefox.desktop 
	       rm $CWD/firefox
       fi
       if [ -f "$CWD/clementine" ];then
         cp $APPWAY/clementine.desktop $APPWAY/clementine.desktop.old
         cp $CWD/../desktop/clementine.desktop $APPWAY/clementine.desktop 
	       rm $CWD/clementine
       fi
         cp $APPWAY/flcards.desktop $APPWAY/flcards.desktop.old
         cp $CWD/../desktop/flcards.desktop $APPWAY/flcards.desktop 
       update-desktop-database

      echo "================================================================="
      echo "===                 Installation terminée                     ==="
      echo "===      Lancez les scripts pour personnaliser le bureau      ==="
      echo "================================================================="
   else
         cp $APPWAY/flcards.desktop $APPWAY/flcards.desktop.old
         cp $CWD/../desktop/flcards.desktop $APPWAY/flcards.desktop 
       update-desktop-database
      echo "================================================================="
      echo "===              La procédure à été interrompue               ==="
      echo "===          Aucun programme supplémentaire installé          ==="
      echo "===      Lancez les scripts pour personnaliser le bureau      ==="
      echo "================================================================="
   fi
fi

exit 0

