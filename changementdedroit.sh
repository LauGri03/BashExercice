#!/bin/bash
function veriffichier(){
	[ -e $1 ]
	if [ $? = 0 ]
	then
		return 0
	else
		return 1
	fi
}
function calculdroit(){
DROIT=0
	for i in $1 $2 $3
	do
		case $i in
				[rR])
					DROIT=`expr $DROIT + 4`
					;;
				[wW])
					DROIT=`expr $DROIT + 2`
					;;
				[xX])
					DROIT=`expr $DROIT + 1`
					;;
		esac

	done
	return 0
}
function changerdroits(){
	chmod "$1$2$3" $4
	if [ $? = 0 ]
	then
		echo "Les droits du fichier $4 ont ete modifies pour $1$2$3"
	else
		echo "Impossible de changer les droits sur le fichier $4"
		exit 1
	fi
}

#bloc fichier 
while [ -z $FICHIER ]
do
	read -p "Veuillez entrer le nom du fichier : " FICHIER
done
veriffichier $FICHIER
while [ $? = 1 ]
do
	read -p "Le fichier n'existe pas, veuillez entrer un fichier valide : " FICHIER
	veriffichier $FICHIER
done

#bloc user
while [ -z $DROITUSER ]
do
	read -p "VeuiLez entrer les droits pour le prorietaire (r = read, w = write, x = execute : " DROITUSER
done
calculdroit `echo $DROITUSER | cut -c 1` `echo $DROITUSER | cut -c 2` `echo $DROITUSER | cut -c 3`
DROITUSER=$DROIT

#bloc groupe
while [ -z $DROITGROUPE ]
do
	read -p "VeuiLez entrer les droits pour le groupe (r = read, w = write, x = execute : " DROITGROUPE
done
calculdroit `echo $DROITGROUPE | cut -c 1` `echo $DROITGROUPE | cut -c 2` `echo $DROITGROUPE | cut -c 3`
DROITGROUPE=$DROIT

#bloc autre
while [ -z $DROITAUTRE ]
do
	read -p "VeuiLez entrer les droits pour les autres (r = read, w = write, x = execute : " DROITAUTRE
done
calculdroit `echo $DROITAUTRE | cut -c 1` `echo $DROITAUTRE | cut -c 2` `echo $DROITAUTRE | cut -c 3`
DROITAUTRE=$DROIT

changerdroits $DROITUSER $DROITGROUPE $DROITAUTRE $FICHIER 
exit 0

