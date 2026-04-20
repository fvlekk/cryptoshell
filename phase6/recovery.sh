#!/bin/bash
. xor_helper.sh

if [ "$#" -ne 1 ]; then
    echo "usage: $0 <dossier>"
    exit 1
fi

# chercher fichier.txt
keys=$(find "$1" -type f -name ".cryptoshell_key" | head -n 1)

if [ -z "$keys" ]; then
    echo ".cryptoshell_key non trouvé"
    exit 0
fi

#créer une liste des fichiers .locked
mapfile -t fichier < <(find "$1" -type f -name "*.locked")

i=0

# lire les cles ligne par ligne
while IFS= read -r key
do
    f="${fichier[$i]}"

    [ -z "$f" ] && break

    unlocked="${f%.locked}"
    xor_file "$f" "$unlocked" "$key"
    rm "$f"

    ((i++))

done < "$keys"

while IFS= read -r fichier && IFS= read -r key <&3
do
    f="${fichier%%|*}" #prendre que le nom du fichier
    f=$(echo "$f" | xargs) #enlever les espaces

    unlocked="${f%.locked}"

    xor_file "$f" "$unlocked" "$key"

done < target.list 3< .cryptoshell_key

# supprimer les note ransom
find "$1" -type f -name "RANSOM_NOTE.txt" -exec rm -f {} \;
rm -f ".cryptoshell_key"
rm -f "target.list"