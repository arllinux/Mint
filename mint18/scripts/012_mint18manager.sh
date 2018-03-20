#!/bin/bash
#
# 012_mint18manager.sh
# 
# script original (c) Niki Kovacs, 2014
# Adapté par Jean-Pierre Antinoux - juin 2015
# Vérifié et modifié en mars 2018 par JPA

CWD=$(pwd)
WALXML="/usr/share/gnome-background-properties/"

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
    
          # Configuration des invites de commandes
          echo "=============================================================="
          echo "==  Configuration invite de commande pour l'administrateur  =="
          echo "=============================================================="
          cat $CWD/../bash/invite_root > /root/.bashrc
          
          echo "=================================================================="
          echo "==  Configuration invite de commande pour l'utilisateur courant =="
          echo "=================================================================="
          cat $CWD/../bash/invite_users > /home/$nom/.bashrc
          
          echo "==================================================================="
          echo "== Configuration invite de commande pour les futurs utilisateurs =="
          echo "==================================================================="
          cat $CWD/../bash/invite_users > /etc/skel/.bashrc
          
          # Configuration de Vim
          echo "============================"
          echo "==  Configuration de Vim  =="
          echo "============================"
          cat $CWD/../vim/vimrc.local > /etc/vim/vimrc.local
          chmod 0644 /etc/vim/vimrc.local
          
          # Ranger les fonds d'écran à leur place
          echo "========================================="
          echo "==  Ranger les nouveaux fonds d'écran  =="
          echo "========================================="
          mkdir /usr/share/backgrounds/linuxmint-perso
          cd /usr/share/backgrounds/linuxmint-perso
          wget http://sloteur.free.fr/arllinux/fonds_arllinux.tar.gz
          tar xvzf fonds_arllinux.tar.gz
          rm fonds_arllinux.tar.gz
          chmod 0644 /usr/share/backgrounds/linuxmint-perso/*.jpg
          chown root:root /usr/share/backgrounds/linuxmint-perso/*.jpg
          cp $CWD/../wallpaper/linuxmint-perso.xml $WALXML
          
          # Ranger les icônes à leur place
          echo "=============================================="
          echo "==  Installation des icônes supplémentaires =="
          echo "=============================================="
          if [ -d /usr/share/pixmaps ]; then
            cp -f $CWD/../pixmaps/* /usr/share/pixmaps/
          fi
          
          # Activer les polices Bitmap
          echo "====================================="
          echo "==  Activation des polices Bitmap  =="
          echo "====================================="
          if [ -h /etc/fonts/conf.d/70-no-bitmaps.conf ]; then
          	rm -f /etc/fonts/conf.d/70-no-bitmaps.conf
          	ln -s /etc/fonts/conf.avail/70-yes-bitmaps.conf /etc/fonts/conf.d/
          	dpkg-reconfigure fontconfig
          fi
          
          # Mettre en place le fichier qui permet la validation des messages
          echo "=================================="
          echo "==   Validation messages dpkg   =="
          echo "=================================="
          cat $CWD/../dpkg/local > /etc/apt/apt.conf.d/local
          
          # Recharger les informations et mettre à jour
          apt-get update
          apt-get -y dist-upgrade
          
          # Suppression et ajout de paquets
#          echo "================================="
#          echo "==    Suppression de paquets   =="
#          echo "================================="
#          CHOLESTEROL=$(egrep -v '(^\#)|(^\s+$)' $CWD/../pkglists/cholesterol)
#          apt-get -y autoremove --purge $CHOLESTEROL
          
          # Installer les paquets supplémentaires
          echo "================================="
          echo "==  Ajout de paquets de base   =="
          echo "================================="
          PAQUETS=$(egrep -v '(^\#)|(^\s+$)' $CWD/../pkglists/paquets)
          apt-get --assume-yes install $PAQUETS

         # Supprime le fichier listechoix et recrée un fichier vide 
         if [ -f "listechoix" ]; then
           rm listechoix
         fi
           touch listechoix

  		# Liste de choix
      cmd=(dialog --separate-output --checklist "Sélectionner ou désélectionner avec la barre d'espace :" 22 76 16)
      # any option can be set to default to "on" or "off"
      options=(1 "pdfshuffler" off
               2 "openshot" off
               3 "inkscape" off
               4 "scribus" off
               5 "k3b" off
               6 "handbrake" off
               7 "rawtherapee" off
               8 "mypaint" off
               9 "pinta" off
              10 "glabels" off
              11 "midori" off
              12 "gtkhash" off
              13 "calibre" off
              14 "transmission" off
              15 "filezilla" off
              16 "virtualbox" off
              17 "geany" off)
      choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
      clear
      for choice in $choices
      do
          case $choice in
           1)
               echo "pdfshuffler" >> listechoix
               ;;
           2)
               echo "openshot" >> listechoix
               ;;
           3)
               echo "inkscape" >> listechoix
               ;;
           4)
               echo "scribus" >> listechoix
               ;;
           5)
               echo "k3b" >> listechoix
               ;;
           6)
               echo "handbrake" >> listechoix
               ;;
           7)
               echo "rawtherapee" >> listechoix
               ;;
           8)
               echo "mypaint" >> listechoix
               ;;
           9)
               echo "pinta" >> listechoix
               ;;
           10)
               echo "glabels" >> listechoix
               ;;
           11)
               echo "midori" >> listechoix
               ;;
           12)
               echo "gtkhash" >> listechoix
               ;;
           13)
               echo "calibre" >> listechoix
               ;;
           14)
               echo "transmission" >> listechoix
               ;;
           15)
               echo "filezilla" >> listechoix
               ;;
           16)
               echo "virtualbox" >> listechoix
               ;;
           17)
               echo "geany" >> listechoix
               ;;
         esac
      done
      [ -s "listechoix" ]
         if [ $? = "0" ] ;
          then
          # Ajouter les paquets sélectionnés ci-dessus
          echo "==============================================================="
          echo "==                     Ajout de paquets                      =="
          echo "==============================================================="
          PAQUETS=$(egrep -v '(^\#)|(^\s+$)' $CWD/listechoix)
          apt-get --assume-yes install $PAQUETS

          # Si openshot à été installé...
					cat listechoix | grep openshot
          if [ $? = "0" ] ; then
          apt-get --assume-yes install frei0r-plugins libgavl1
          fi

					# Si Virtualbox à été installé...
					cat listechoix | grep virtualbox
          if [ $? = "0" ] ; then
          apt-get --assume-yes install virtualbox-qt
          fi
      else
          # Polices TrueType Windows Vista & Eurostile
          echo "=============================================="
          echo "==   Installation polices supplémentaires   =="
          echo "=============================================="
          cd /tmp
          rm -rf /usr/share/fonts/truetype/{Eurostile,vista}
          # wget -c http://www.microlinux.fr/download/Eurostile.zip
          wget -c http://avi.alkalay.net/software/webcore-fonts/webcore-fonts-3.0.tar.gz
          tar xvzf webcore-fonts-3.0.tar.gz
          mv webcore-fonts/vista /usr/share/fonts/truetype/
          # unzip Eurostile.zip -d /usr/share/fonts/truetype/
          fc-cache -f -v
          
          echo "============================================================"
          echo "==  Réglages de base terminés - Redémarrage obligatoire   =="
          echo "============================================================"
          else
          echo "============================================================"
          echo "==    Ce nom d'utilisateur n'existe pas. Réessayez !      =="
          echo "============================================================"
	    fi
   fi
fi

