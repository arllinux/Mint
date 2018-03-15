#!/bin/bash

# Script pour concaténer dans vidéos sans les réencoder
# Astuce donnée par Adrien Linuxtricks
# https://www.youtube.com/watch?v=b9_l3KAsDYg à 11:16

# Toutes les vidéos doivent être dans le même répertoire : ici "joindre_videos"
# Toutes les vidéos doivent avoir un nom commençant par "out"
# On peut choisir le format de vidéos souhaité par la variable "FORMAT"
# Il faut que ce soit le même que les vidéos sources

FORMAT="mp4"

if [ -f concat.txt ];
				then
				rm concat.txt
fi

> concat.txt
date=$(date +"%d-%m-%Y")

for f in $(ls out*)
do
				echo file \'$f\' >> concat.txt
done

ffmpeg -f concat -i concat.txt -c copy $date.$FORMAT
echo "========================================="
echo "==      Votre vidéo est prête !!       =="
echo "========================================="
