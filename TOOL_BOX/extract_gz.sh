#!/bin/bash

#Script pour extraire les archives gz d'un répertoire.
# NOTE: replacer "my_repository" par la vraie valeur.

#réperoire contenant les archives gz
DIRECTORY_GZ_FILES=$1

# répertoire de destination pour les fichiers extraits
OUTPUT_DIR=/my_repository
if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir "$OUTPUT_DIR"
    chmod 757 "$OUTPUT_DIR"
fi

LIST_GZ_FILES=$(ls "$DIRECTORY_GZ_FILES"/*.gz)

for gz_file in $LIST_GZ_FILES;do
    NAME=$(basename "${gz_file}" .gz)
    echo "ARCHIVE: $DIRECTORY_GZ_FILES/$gz_file -> $OUTPUT_DIR/$NAME.log"
    gunzip -c "$DIRECTORY_GZ_FILES"/"$gz_file" > "$OUTPUT_DIR"/"$NAME".log
done