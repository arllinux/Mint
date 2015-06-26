# Ranger les fonds d'écran à leur place
CWD=$(pwd)
WALXML="/usr/share/gnome-background-properties/"
 mkdir /usr/share/backgrounds/linuxmint-perso
 cd /usr/share/backgrounds/linuxmint-perso
 wget http://sloteur.free.fr/arllinux/fonds_arllinux.tar.gz
 tar xvzf fonds_arllinux.tar.gz
 rm fonds_arllinux.tar.gz
 chmod 0644 /usr/share/backgrounds/linuxmint-perso/*.jpg
 chown root:root /usr/share/backgrounds/linuxmint-perso/*.jpg
 cp $CWD/../wallpaper/linuxmint-perso.xml $WALXML

