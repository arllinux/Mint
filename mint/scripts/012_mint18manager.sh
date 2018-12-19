#!/bin/bash
#
# 012_mint18manager.sh
# 
# script original (c) Niki Kovacs, 2014
# Adapté par Jean-Pierre Antinoux - juin 2015
# Vérifié et modifié en mars 2018 par JPA
# Nouvelles modifs (allégé) en décembre 2018 par JPA

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
          PAQUETS=$(egrep -v '(^\#)|(^\s+$)' $CWD/../pkglists/paquets-base)
          apt-get --assume-yes install $PAQUETS

          # Polices TrueType Windows Vista & Eurostile
          echo "=============================================="
          echo "==   Installation polices supplémentaires   =="
          echo "=============================================="
          cd /tmp
          rm -rf /usr/share/fonts/truetype/{Eurostile,vista}
          wget -c http://avi.alkalay.net/software/webcore-fonts/webcore-fonts-3.0.tar.gz
          tar xvzf webcore-fonts-3.0.tar.gz
          mv webcore-fonts/vista /usr/share/fonts/truetype/
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

