#!/bin/bash

# Script permettant la récupération des informations de coredump sur
# sur les serveurs dont la liste est passée en paramètres
#
# NOTE: replacer "my_repository_1" , "my_repository_2", "my_repository_3" et login par les vraies valeurs.

CUR_DATE=$(date +"%Y%m%d-%H%M")

server_list=$1
declare -a server_array
declare -i index=0

# répertoire de destination pour la copie des fichiers de coredump
COREDUMP_DEST_DIR=/my_repository_1
if [ ! -d $COREDUMP_DEST_DIR ]; then
    mkdir $COREDUMP_DEST_DIR
    chmod 757 $COREDUMP_DEST_DIR
fi

# récupération du contenu du fichier dans un tableau
while read -r line; do
    server_array[$index]="$line"
    index=$((index+1))
done < "$server_list"

for server in "${server_array[@]}"; do
    echo "Connexion au serveur $server"
    
    # création des répertoires de destination (machine distante)
    file_name="coredump_$server-$CUR_DATE.txt"
    
    # my_repository_2
    JGI_DIR=/my_repository_2
    echo "Nom du fichier de coredump: $file_name"
    if [[ $(ssh login@"$server" test -d $JGI_DIR && echo exists) ]]; then
         echo "Repertoire $JGI_DIR existant sur $server."
         echo ""
    else
        echo "Creation du repertoire $JGI_DIR sur $server."
        ssh login@"$server" mkdir $JGI_DIR
        ssh login@"$server" chmod 757 $JGI_DIR
        echo ""
    fi

    # my_repository_3
    COREDUMP_DIR=/my_repository_3
    if [[ $(ssh login@"$server" test -d $COREDUMP_DIR && echo exists) ]]; then
         echo "Repertoire $COREDUMP_DIR existant sur $server."
         echo ""
    else
        echo "Creation du repertoire $COREDUMP_DIR sur $server."
        ssh login@"$server" mkdir $COREDUMP_DIR
        ssh login@"$server" chmod 757 $COREDUMP_DIR
        echo ""
    fi

    output=$COREDUMP_DIR/$file_name
    ssh login@"$server" "sudo coredumpctl info > $output"
    
    # on peut le faire directement de cette façon, en créant le fichier de sortie
    # sur la machine qui exécute le script au lieu du remote.
    # ssh login@$server sudo coredumpctl info > $COREDUMP_DEST_DIR/$file_name

    scp login@"$server":$COREDUMP_DIR/"$file_name" $COREDUMP_DEST_DIR/"$file_name"

done

