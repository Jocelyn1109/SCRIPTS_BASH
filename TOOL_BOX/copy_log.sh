#!/bin/bash

# Script de copie d'une liste de fichiers de log.
# 1er argument: la liste des fichiers de log à copier.
# 2nd argument: le nom du serveur où se trouvent les fichiers de log.
# 3eme argument: le repertoire source.
#
# NOTE: replacer "my_repository" et login par les vraies valeurs.

CUR_DATE=$(date +"%Y%m%d-%H%M")

# répertoire de destination pour la copie des fichiers de log
LOG_DEST_DIR=/my_repository
if [ ! -d $LOG_DEST_DIR ]; then
    mkdir $LOG_DEST_DIR
    chmod 757 $LOG_DEST_DIR
fi

mkdir $LOG_DEST_DIR/"$2"
chmod 757 $LOG_DEST_DIR/"$2"
mkdir $LOG_DEST_DIR/"$2"/"$CUR_DATE"
chmod 757 $LOG_DEST_DIR/"$2"/"$CUR_DATE"

# nom du fichier des fichiers de log et nom du serveur source
list_files=$1
echo "serveur_source: $2"
echo ""

LOG_LISTE=$(cat "$list_files")
echo "Liste des log: $LOG_LISTE"
echo ""

nbre_files=$(wc -l < "$list_files")
echo "Nombre de fichiers a copier: $nbre_files"
echo ""

for log in $LOG_LISTE;do
    echo "copie de $log"
    scp login@"$2":"$3"/"$log" $LOG_DEST_DIR/"$2"/"$CUR_DATE"/"$log"
    echo ""
done