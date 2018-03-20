#!/bin/bash
#
# 001_archives_films.sh
# 
# Jean-Pierre Antinoux - mars 2018

CWD=$(pwd)
				 cd $CWD/joindre_videos
         wget http://sloteur.free.fr/arllinux/videos/5_videos_test.tar.gz
         tar xvf 5_videos_test.tar.gz
         rm 5_videos_test.tar.gz
exit 0
