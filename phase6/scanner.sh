#!/bin/bash

# verifier argument
if [ $# -ne 1 ]; then
    echo "usage: ./scanner.sh <repertoire>"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "Repertoire invalide"
    exit 1
fi

nb_locked=0
nb_note=0
nb_cs=0
nb_key=0
nb_pattern=0

echo "----- rapport IoC cryptoShell -----"
echo
echo "repertoire analyse : $1"
echo

while IFS= read -r f #parcours du repertoire 
do
    if [[ "$f" == *.locked ]]; then
        ((nb_locked++)) #incrementattion du compteur pour chaque IoC
    fi

    if [[ "$(basename "$f")" == "RANSOM_NOTE.txt" ]]; then
        ((nb_note++))
    fi

    if [[ "$(basename "$f")" == ".cs_count" ]]; then
        ((nb_cs++))
    fi

    if [[ "$(basename "$f")" == ".cryptoshell_key" ]]; then
        ((nb_key++))
    fi
done < <(find "$1" -type f)

#detetction de patternes 
nb_pattern=$(grep -r -l -E "xor|locked|RANSOM" --include="*.sh" "$1" 2>/dev/null | wc -l) #le -E est pour pouvoire utiliser les | comme des ou logique 

#rapport
echo ".locked trouves         : $nb_locked"
echo "RANSOM_NOTE.txt         : $nb_note"
echo "caches .cs_count        : $nb_cs"
echo "caches .cryptoshell_key : $nb_key"
echo "scripts avec patterns suspects  : $nb_pattern"

total=$((nb_locked + nb_note + nb_cs + nb_key + nb_pattern))

echo
echo "total IoC detectes : $total"
echo "------------------------------------"