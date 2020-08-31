#!/bin/bash
function verifexist(){
	[ -e $1 ]
	if [ $? -eq 0 ]
	then
		return 0
	else
		return 1
	fi
}

function action(){
	verifexist $2
	case $1 in 
			1)
				if [ -e $2 ]
				then
					echo "Le fichier $2 existe deja, impossible de le creer"
					exit 1
					
				else
					touch "$2"
					echo "Le fichier $2 a bien ete cree"
					exit 0
				fi
				;;
			2)
				if [ -e $2 ]
				then
					rm "$2"
					echo "Le fichier $2 a bien ete supprime"
					exit 0
				else
					echo "Le fichier $2 n'existe pas, il ne peux pas etre supprime"
					exit 1
				fi
				;;
			*)
				exit 1
				;;
	esac
}

function menu(){
	while [ "$1" != "0" ]
	do
		echo "1. Creer un fichier"
		echo "2. Supprimer un fichier"
		read ACTION
		case $ACTION in 
				[12])
					return 0
					;;
				*) 
					menu 1
					;;
		esac
	done
}

menu
read -p "Merci d'indiquer le chemin du fichier : " FICHIER
action $ACTION $FICHIER

