#!/bin/bash
#
# Auteur: Jocelyn GIROD - janvier 2018

clear

directory=$1

#Fonction globale permettant l'affichage des filtres
function displayChoice () {
echo "1 - fichier cpp (.cpp)"
echo "2 - fichier c (.c)"
echo "3 - fichier hpp (.hpp)"
echo "4 - fichier h (.h)"
echo "5 - fichier properties (.properties)"
echo "6 - fichier txt (.txt)"
echo "7 - fichier ini (.ini)"
echo "8 - fichier xsl (.xsl)"
echo "9 - fichier wsdl (.wsdl)"
echo "10 - fichier sh (.sh)"
echo "11 - tous les types"
echo "12 - aucun filtre"
}

echo ""
echo "Rechercher dans fichiers: "
echo ""
displayChoice

read -r filtre
echo ""
case $filtre in
1) extension="*.cpp";;
2) extension="*.c";;
3) extension="*.hpp";;
4) extension="*.h";;
5) extension="*.properties";;
6) extension="*.txt";;
7) extension="*.ini";;
8) extension="*.xsl";;
9) extension="*.wsdl";;
10) extension="*.sh";;
11) extension="";;
12) extension="*.*";;
esac

echo ""
echo "Chaine a rechercher: "
read -r stringToFind

echo ""
echo "Voulez-vous sauvegarder le resultat dans un fichier ?: y/n"
read -r save
echo ""
echo "Processing..."


if [[ "$filtre" == "11" ]]
then
	if [[ "${save}" = *"Y" || "${save}" = *"y" ]]
	then
		find "$directory" -print0 -iname "*.cpp" -o -iname "*.c" -o -iname "*.hpp" -o -iname "*.h" -o -iname "*.properties" -o -iname "*.txt" -o -iname "*.ini" -o -iname "*.xsl" -iname "*.wsdl" -o -iname "*.sh" | xargs -0 grep "$stringToFind" -sl >> find_string_result.txt
	else
		find "$directory" -print0 -iname  "*.cpp" -o -iname "*.c" -o -iname "*.hpp" -o -iname "*.h" -o -iname "*.properties" -o -iname "*.txt" -o -iname "*.ini" -o -iname "*.xsl" -iname "*.wsdl" -o -iname "*.sh" | xargs -0 grep "$stringToFind" -sl
	fi
else
	if [[ "${save}" = *"Y" || "${save}" = *"y" ]]
	then
		find "$directory" -print0 -iname  "$extension" | xargs -0 grep "$stringToFind" -sl >> find_string_result.txt
	else
		find "$directory" -print0 -iname  "$extension" | xargs -0 grep "$stringToFind" -sl
	fi
fi