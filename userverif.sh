#!/bin/bash
while [ -z $USERTOVALIDATE ]
do
read -p "Veuillez entrer le nom d'utilisateur a verifier : " USERTOVALIDATE
done 
if [ "`cat /etc/passwd | cut -d: -f1 | grep $USERTOVALIDATE`" = "$USERTOVALIDATE" ] 
then
	echo "L'utilisateur $USERTOVALIDATE semble exister"
	exit 0 
else
	echo "L'utilisateur $USERTOVALIDATE ne semble pas exister"
	exit 1
fi

