#!/bin/bash

#verifier si un repertoire est passer en parametre

if [ $# -ne 1 ] ; then 
    echo "usage : ./recon.sh <repertoire>"
    exit 1
fi

#virifier si le repertoire existe

if [ ! -d "$1" ] ; then 
    echo "repertoire invalide" 
    #possibilite de supprimer ce message pour ne pas etre detetcer 
    exit 1 
fi

>target.list

#utilisation du find 
t=0
i=0
while read f 
do 

s=$(stat -c%s "$f")
d=$(stat -c%y "$f" | cut -d '.' -f1)

echo "$f | $s bytes | $d" >> target.list
((i++))
((t+=$s))
done < <(find "$1" -type f \( -name "*.txt" -o -name "*.dat" \))
echo "-----------------------------" >> target.list 
echo "nbr fichier : $i" >> target.list 
echo "taille total: $t bytes" >> target.list 
