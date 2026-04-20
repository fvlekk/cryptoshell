#!/bin/bash
. xor_helper.sh
#verifier si 1 parametres sont passer en argument 

if [ $# -ne 1 ] ; then 
    echo "usage : ./decrypt.sh <fichier>"
    exit 1
fi

#virifier si le fichier existe

if [ ! -f "$1" ] ; then 
    echo "fichier invalide" 
    #possibilite de supprimer ce message pour ne pas etre detetcer 
    exit 1 
fi



key=$(sed -n '1p' .cryptoshell_key | tr -d '\n')
unlocked="${1%.locked}"
xor_file "$1" "$unlocked" "$key"
rm "$1"

