#!/bin/bash
#
# Auteur: Jocelyn GIROD - juillet 2023
# 
# But du script : lister récursivement les fichiers à partir d'un répertoire
# et affiche leur encodage
#

directory=$1

function checkEncoding () {

filePath=$(readlink -f $f);
	if [[ "${filePath}" != *"zip"* && -n "${filePath}" ]]
	then
		if [[ "${save}" = *"Y" || "${save}" = *"y" ]]
		then
			file -i $filePath >> check_encoding_result.txt;
		else
			file -i $filePath;
		fi
	fi	
}

#Fonction globale permettant l'affichage des filtres
function displayChoice () {

echo "1 - fichier cpp (.cpp)"
echo "2 - fichier hpp (.hpp)"
echo "3 - fichier h (.h)"
echo "4 - fichier ini (.ini)"
echo "5 - fichier sh (.sh)"
echo "6 - fichier txt (.txt)"
echo "7 - fichier csv (.csv)"
echo "8 - fichier xsl (.xsl)"
echo "9 - fichier wsdl (.wsdl)"
echo "10 - tous les types"
echo "11 - aucun filtre"

}

echo "Filtre par type de fichier a verifier:"
echo ""
displayChoice

read -r filtre
echo ""
case $filtre in
1) extension="*.cpp";;
2) extension="*.hpp";;
3) extension="*.h";;
4) extension="*.ini";;
5) extension="*.sh";;
6) extension="*.txt";;
7) extension="*.csv";;
8) extension="*.xsl";;
9) extension="*.wsdl";;
10) extension="";;
11) extension="*.*";;
esac

echo ""
echo "Voulez-vous sauvegarder le resultat dans un fichier ?: y/n"
read -r save
echo ""
echo "Processing..."

if [[ "$filtre" == "10" ]]
then
	for f in $(find $directory -iname "*.cpp" -o -iname "*.hpp" -o -iname "*.h" -o -iname "*.ini" -o -iname "*.sh" -o -iname "*.txt" -o -iname "*.csv" -o -iname "*.xsl" -iname "*.wsdl" -not -iname "*.zip" -type f)
	do
		checkEncoding
	done
else
	for f in $(find $directory -iname "${extension}" -not -iname "*.zip" -type f)
	do
		checkEncoding
	done
fi
