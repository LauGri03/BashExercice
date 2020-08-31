#!/bin/bash
GROUPLIST=`cat /etc/group | cut -d: -f1`
function verifgroup(){
	for GROUP in $GROUPLIST
	do
		if [ "$GROUP" = "$1" ]
		then
			echo "Le groupe $1 semble exister"
			exit 0
		fi
	done
	echo "Le groupe $1 ne semble pas exister"
	exit 1
}
while [ -z $GROUPTOVALIDATE ]
do
read -p "Veuillez entrer le groupe a verifier : " GROUPTOVALIDATE
done
verifgroup $GROUPTOVALIDATE


