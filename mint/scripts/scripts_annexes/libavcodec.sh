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
      echo " --> OK Le dépot ppa a été ajouté" > infoprocedure
      echo " >------------------------------<" >> infoprocedure
    else
      echo " !!! L'ajout du dépot ppa n'a pas aboutie" > infoprocedure
      echo " >--------------------------------------<" >> infoprocedure
    fi

			apt-get update
			if [ $? = 0 ]; then
      echo " --> OK Mise à jour de la liste des paquets" >> infoprocedure
      echo " >----------------------------------------<" >> infoprocedure
    else
      echo " !!! La maj de la liste des paquets n'a pas aboutie" >> infoprocedure
      echo " >------------------------------------------------<" >> infoprocedure
    fi
  
		
			apt-get install libav-tools libavcodec-extra-56	
			if [ $? = 0 ]; then
      echo " --> OK Installation des codecs pour Firefox 50" >> infoprocedure
      echo " >--------------------------------------------<" >> infoprocedure
    else
      echo " !!! L'installation des codecs n'a pas aboutie" >> infoprocedure
      echo " >-------------------------------------------<" >> infoprocedure
    fi

			apt-get upgrade
			if [ $? = 0 ]; then
      echo " --> OK Mise à jour du système" >> infoprocedure
      echo " >---------------------------<" >> infoprocedure
    else
      echo " !!! La mise à jour du système n'a pas aboutie" >> infoprocedure
      echo " >-------------------------------------------<" >> infoprocedure
    fi
		echo " --> Redémarrer Firefox si celui-ci est en route" >> infoprocedure
		echo " >---------------------------------------------<" >> infoprocedure
		
		# Afficher le résultat de la procédure
		cat infoprocedure
		rm infoprocedure
		
fi

exit 0
