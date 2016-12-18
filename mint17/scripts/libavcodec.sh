#!/bin/bash
#
# libavcodec.sh
# ppa pour codecs Firefox 50 
# Jean-Pierre Antinoux - Décembre 2016

CWD=$(pwd)


if [ $USER != "root" ] ;
    then
	echo "Pour exécuter ce script il faut être l'utilisateur root !"
else

  # Ajouter le dépot ppa
    	add-apt-repository ppa:heyarje/libav-11
			if [ $? = 0 ]; then
      echo " --> OK Le dépot ppa a été ajouté"
      echo " >------------------------------<"
    else
      echo " !!! L'ajout du dépot ppa n'a pas aboutie"
      echo " >--------------------------------------<"
    fi

			apt-get update
			if [ $? = 0 ]; then
      echo " --> OK Mise à jour de la liste des paquets"
      echo " >----------------------------------------<"
    else
      echo " !!! La mise à jour de la liste des paquets n'a pas aboutie"
      echo " >--------------------------------------------------------<"
    fi
  
		
			apt-get install libav-tools libavcodec-extra-56	
			if [ $? = 0 ]; then
      echo " --> OK Installation des codecs pour Firefox 50"
      echo " >----------------------------------------<"
    else
      echo " !!! L'installation des codecs n'a pas aboutie"
      echo " >-------------------------------------------<"
    fi

			apt-get upgrade
			if [ $? = 0 ]; then
      echo " --> OK Mise à jour du système"
      echo " >---------------------------<"
    else
      echo " !!! La mise à jour du système n'a pas aboutie"
      echo " >-------------------------------------------<"
    fi
		echo " --> Redémarrer Firefox si celui-ci est en route"
		echo " >---------------------------------------------<"
fi

exit 0
