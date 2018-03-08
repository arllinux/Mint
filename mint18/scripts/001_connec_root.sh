#!/bin/bash
#
# connect_root.sh
# 
# Jean-Pierre Antinoux - juin 2014


# Création du mot de passe administrateur
echo "================================================="
echo "==               :: Etape 1 ::                 =="
echo "==   Création du mot de passe administrateur.  =="
echo "================================================="
sudo passwd root

# Connection en administrateur
echo
echo "================================================="
echo "==               :: Etape 2 ::                 =="
echo "==      :: Connection en administrateur ::     =="
echo "==   Tapez le mot de passe défini à l'Etape 1  =="
echo "================================================="
su -

exit 0
