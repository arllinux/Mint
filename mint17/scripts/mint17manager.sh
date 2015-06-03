#!/bin/bash
#
# mint17manager.sh
# 
# script original (c) Niki Kovacs, 2014
# Adapté par Jean-Pierre Antinoux - juin 2014

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
    
# Configuration des invites de commandes
echo ":: Configuration invite de commande pour l'administrateur."
cat $CWD/../bash/invite_root > /root/.bashrc
bash -c source ~/.bashrc

echo ":: Configuration invite de commande pour les futurs utilisateurs."
cat $CWD/../bash/invite_users > /etc/skel/.bashrc

echo ":: Configuration invite de commande p our l'utilisateur courant."
cat $CWD/../bash/invite_users > /home/$nom/.bashrc

# Configuration de Vim
apt-get -y install vim
echo ":: Configuration de Vim."
cat $CWD/../vim/vimrc.local > /etc/vim/vimrc.local
chmod 0644 /etc/vim/vimrc.local

# Mise en place du bootsplash
# echo ":: Mise en place du bootsplash. ::"
# cp $CWD/../bootsplash/wwl.tga /boot/grub/

# Configurer grub
# echo ":: Configuration de /etc/default/grub. ::"
# cp /etc/default/grub /etc/default/grub_old
# cat $CWD/../grub/etc/default/grub_800x600 > /etc/default/grub
# update-grub

# Ranger les fonds d'écran à leur place
# A améliorer l'activation automatique !!!!!
cd /usr/share/backgrounds/linuxmint-qiana/
wget http://sloteur.free.fr/wal/fonds_arllinux.tar.gz
tar xvzf fonds_arllinux.tar.gz
rm fonds_arllinux.tar.gz
chmod 0644 /usr/share/backgrounds/linuxmint-qiana*.jpg
chown root:root /usr/share/backgrounds/linuxmint-qiana*.jpg

# Ranger les icônes à leur place
echo ":: Installation des icônes supplémentaires."
if [ -d /usr/share/pixmaps ]; then
  cp -f $CWD/../pixmaps/* /usr/share/pixmaps/
fi

# Activer les polices Bitmap
echo ":: Activation des polices Bitmap."
if [ -h /etc/fonts/conf.d/70-no-bitmaps.conf ]; then
	rm -f /etc/fonts/conf.d/70-no-bitmaps.conf
	ln -s /etc/fonts/conf.avail/70-yes-bitmaps.conf /etc/fonts/conf.d/
	dpkg-reconfigure fontconfig
fi

# Recharger les informations et mettre à jour
apt-get update
apt-get -y dist-upgrade

# Suppression et ajout de paquets
echo ":: Suppression et ajout de paquets. ::"
# Supprimer les paquets inutiles
CHOLESTEROL=$(egrep -v '(^\#)|(^\s+$)' $CWD/../pkglists/cholesterol)
apt-get -y autoremove --purge $CHOLESTEROL

# Installer les paquets supplémentaires
PAQUETS=$(egrep -v '(^\#)|(^\s+$)' $CWD/../pkglists/paquets)
apt-get --assume-yes install $PAQUETS

# Installer les extras
apt-get --assume-yes install ubuntu-restricted-extra

# Désactiver l'IPV6
# echo ":: Désactivation de l'ipv6. ::"
# cp /etc/sysctl.conf /etc/sysctl.conf_old
# cat $CWD/../ipv4-6/etc/sysctl.conf > /etc/sysctl.conf
# sysctl -p

# Polices TrueType Windows Vista & Eurostile
echo ":: Installation polices supplémentaires. ::"
cd /tmp
rm -rf /usr/share/fonts/truetype/{Eurostile,vista}
wget -c http://www.microlinux.fr/download/Eurostile.zip
wget -c http://avi.alkalay.net/software/webcore-fonts/webcore-fonts-3.0.tar.gz
tar xvzf webcore-fonts-3.0.tar.gz
mv webcore-fonts/vista /usr/share/fonts/truetype/
unzip Eurostile.zip -d /usr/share/fonts/truetype/
fc-cache -f -v

echo ":: Réglages de base terminés - Redémarrage obligatoire ::"
    else
       echo "Ce nom d'utilisateur n'existe pas. Réessayez !"
    fi
fi

exit 0
