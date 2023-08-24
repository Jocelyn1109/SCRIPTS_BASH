#!/bin/bash

# Permet de récupérer le chemin d'un fichier contenu dans un xml en base de donnée
# NOTE: replacer "my_repository", "serveur_de_bd", "bd_name", "my_table", "my_column" et  "pathfile" par les vraies valeurs.

CUR_DATE=$(date +"%Y%m%d-%H%M")

# répertoire de destination pour le fichier txt des résultats
OUTPUT_TXT_DIR=/my_repository
if [ ! -d $OUTPUT_TXT_DIR ]; then
    mkdir $OUTPUT_TXT_DIR
    chmod 757 $OUTPUT_TXT_DIR
fi

mkdir $OUTPUT_TXT_DIR/"$CUR_DATE"

# nom du fichier contenant les flux
list_flux_file=$1
echo "Fichier des flux: $list_flux_file"
echo ""

FLUX_LISTE=$(cat "$list_flux_file")
echo "Liste des flux: $FLUX_LISTE"
echo ""

for flux in $FLUX_LISTE;do
    echo "Flux $flux:"
    ssh serveur_de_bd "psql bd_name -Atxc \" select * from my_table where my_column='$flux';\"" | grep pathfile
done > $OUTPUT_TXT_DIR/"$CUR_DATE"/path_file_output.txt