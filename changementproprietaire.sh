#!/bin/bash
function veriffichier(){
	[ -e $1 ]
	if [ $? = 0 ]
	then
		return 0
	else
		echo "Le fichier n'existe pas, veuillez entrer un fichier valide"
		return 1
	fi
}

function verifgroup(){
GROUPELIST=`cat /etc/group | cut -d: -f1`
	
	for GROUPE in $GROUPELIST
	do
		if [ "$GROUPE" = "$1" ]
		then
			return 0
		fi
	done
	echo "Le groupe $1 n'existe pas, veuillez entrer un groupe valide"
	return 1
}

function verifuser(){
UTILISATEURLIST=`cat /etc/passwd | cut -d: -f1`
	for UTILISATEUR in $UTILISATEURLIST
	do 
		if [ "$UTILISATEUR" = "$1" ]
		then 
			return 0
		fi
	done
	echo "L'utilisateur $1 n'existe pas, veuillez entre un utilisateur valide"
	return 1
}

function changementowner(){
	chown "${1}:${2}" "$3" #user groupe fichier
	if [ $? = 0 ]
	then
		echo "Le fichier $3 appartient maintenant a l'utilisateur $1 (groupe: $2)"
	else
		echo "Impossible de changer le proprietaire et le groupe du fichier $3"
		return 1
	fi
	return 0
}

#bloc fichier
while [ -z $FICHIER ]
do
	read -p "Veuillez entrer le nom du fichier a modifier : " FICHIER
done
veriffichier $FICHIER
while [ $? = 1 ]
do
	read -p "Fichier : " FICHIER
	veriffichier $FICHIER
done

#Bloc utilisateur
while [ -z $UTILISATEUR ]
do 
	read -p "Veuillez entrer le nom d'un utilisateur : " UTILISATEUR
done
verifuser $UTILISATEUR
while [ $? = 1 ]
do
	read -p "Utilisateur : " UTILISATEUR
	verifuser $UTILISATEUR
done

#Bloc groupe
while [ -z $GROUPE ]
do 
        read -p "Veuillez entrer le nom d'un groupe : " GROUPE
done
verifgroup $GROUPE
while [ $? = 1 ]
do
        read -p "Groupe : " GROUPE
        verifgroup $GROUPE
done

changementowner $UTILISATEUR $GROUPE $FICHIER

exit 0




