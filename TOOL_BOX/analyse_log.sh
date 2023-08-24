#!/bin/bash

# Script d'analyse d'une liste de fichiers de log.
# 1er argument: fichier contenant la liste des mots clé à rechercher dans les logs.
# 2nd argument: répertoire ou fichier contenant les logs.
#
# NOTE: replacer "my_repository" par la vraie valeur.

CUR_DATE=$(date +"%Y%m%d-%H%M")
server_name=$3

# répertoire de destination pour le fichier txt des résultats
OUTPUT_TXT_DIR=/my_repository
if [ ! -d $OUTPUT_TXT_DIR ]; then
    mkdir $OUTPUT_TXT_DIR
    chmod 757 $OUTPUT_TXT_DIR
fi

if [ ! -d $OUTPUT_TXT_DIR/ANALYSE ]; then
    mkdir $OUTPUT_TXT_DIR/ANALYSE
    chmod 757 $OUTPUT_TXT_DIR/ANALYSE
fi

if [ ! -d $OUTPUT_TXT_DIR/ANALYSE/"$CUR_DATE" ]; then
    mkdir $OUTPUT_TXT_DIR/ANALYSE/"$CUR_DATE"
    chmod 757 $OUTPUT_TXT_DIR/ANALYSE/"$CUR_DATE"
fi

list_keyword_file=$1
sed -i.bak 's/\r$//g' "$list_keyword_file"
echo "Fichier des mots cle: $list_keyword_file"
echo ""

log_source=$2
echo "Repertoire ou fichier des logs: $log_source"

echo ""
echo "Voulez-vous sauvegarder le resultat dans un fichier ?: y/n"
read -r save
echo ""

if [[ "${save}" = *"Y" || "${save}" = *"y" ]]
then
    LIST_FILES=$(find "$log_source" -name "*.log")
    for file in $LIST_FILES;do
        while read -r line; do
            echo "Recherche $line dans $file"
            sed -n "/$line/p" "$file"
            echo ""
        done < "$list_keyword_file"
    done > $OUTPUT_TXT_DIR/ANALYSE/"$CUR_DATE"/result_analyse_log_"$server_name".txt
else
    LIST_FILES=$(find "$log_source" -name "*.log")
    for file in $LIST_FILES;do
        while read -r line; do
            echo "Recherche $line dans $file"
            sed -n "/$line/p" "$file"
            echo ""
        done < "$list_keyword_file"
    done
fi
