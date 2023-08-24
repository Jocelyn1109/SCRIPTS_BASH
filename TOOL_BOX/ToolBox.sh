#!/bin/bash
#
# Auteur: Jocelyn GIROD - juillet 2023
# 
# ToolBox
#
# NOTE: remplacer les nom des serveurs par les vrais noms
# ainsi que les login pour les connexions ssh.
#
#

SERVER_NAME=""

#Fonction permettant l'affichage de la liste des serveurs
function displayServerChoice () {

echo "1 - Serveur 1"
echo "2 - Serveur 2"
echo "3 - Serveur 3"
echo "4 - Serveur 4"
echo "5 - Serveur 5"
}

#Fonction permettant la sélection du serveur.
function serverSelect(){

    displayServerChoice
    read -r choice
    echo ""

    case $choice in
    1) SERVER_NAME="serveur01";;
    2) SERVER_NAME="serveur02";;
    3) SERVER_NAME="serveur03";;
    4) SERVER_NAME="serveur04";;
    5) SERVER_NAME="serveur05";;
    *) echo "choix errone !"
    esac
}

clear

while true
do
	echo ""
	echo "TOOLBOX"
    echo "-----------"
	echo ""
	echo "Que souhaitez-sous faire ?"
	echo ""
	echo "1 - Copier des logs,"
	echo "2 - Analyser des logs,"
	echo "3 - Recuperer les chemins des fichiers en BD,"
	echo "4 - Recuperer les coredump sur des serveurs distants,"
  	echo "5 - Extraire des archives gz,"
  	echo "6 - Se connecter a un serveur en ssh,"
  	echo "7 - Rechercher une chaine de caracteres dans des fichiers,"
	echo "8 - Quitter."

	read -r choice
	
	if [[ "$choice" == "8" ]]
	then
		echo ""
		echo "Voulez-vous effacer l'ecran ?: y/n"
		read -r clean
		echo ""

		if [[ "${clean}" = *"Y" || "${clean}" = *"y" ]]; then
			clear
		fi
		
		exit
    elif [[ "$choice" == "1" ]]
	then
		clear
		echo ""
		echo "Liste des fichiers de log a copier: "
		read -r liste
		echo "Serveur ou se trouvent les fichiers de log: "
		serverSelect
		echo "Repertoire source ou se trouvent les fichiers de log sur la machine distante: "
		read -r source_directory
		./copy_log.sh "$liste" $SERVER_NAME "$source_directory"
	elif [[ "$choice" == "2" ]]
	then
		echo ""
		echo "Fichier contenant la liste des mots cle a rechercher dans les logs: "
		read -r keyword_list
		echo "Repertoire ou fichier contenant les logs."
		read -r log_directory
		echo "Serveur des logs: "
		serverSelect
		./analyse_log.sh "$keyword_list" "$log_directory" $SERVER_NAME
	elif [[ "$choice" == "3" ]]
	then
	  echo ""
	  echo "Fichier contenant la liste des flux: "
	  read -r list_flux
	  ./get_file_path.sh "$list_flux"
	elif [[ "$choice" == "4" ]]
	then
	  echo ""
	  echo "Fichier contenant la liste des serveurs: "
	  read -r server_list
	  ./get_core_dump.sh "$server_list"
	elif [[ "$choice" == "5" ]]
    then
      echo ""
      echo "Repertoire des archives: "
      read -r archive_directory
      ./extract_gz.sh "$archive_directory"
    elif [[ "$choice" == "6" ]]
    then
      echo ""
      echo "Serveur sur lequel de connecter: "
      serverSelect
      ssh login@$SERVER_NAME
    elif [[ "$choice" == "7" ]]
    then
    	echo ""
		echo "Repertoire contentant les fichiers: "
		read -r file_directory
		./findStringInFile.sh "$file_directory"
	else
		echo ""
		echo "Choix incorrect !"
		echo ""
	fi
done

