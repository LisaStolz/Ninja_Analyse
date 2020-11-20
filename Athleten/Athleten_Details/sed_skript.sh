#!/bin/sh

for i in 1 2 3 4 5 6
do
sed -e '/		{"@context":"http://schema.org","@type":"/d' -e '/Österreich/d' -e '/Schweiz/d' -e '/Ninja Warrior Germany Mixed Ninja Warrior Germany Mixed/d' -e '/Für mehr Daten, bitte Gerät drehen/d' -e 's@<.*>@ @' -e '/^\s*[A-Z]./d' 20_Ergebnisse_Vorrunde_${i}_short.txt | sed -e ':a;N;$!ba;s/\n/, /g' | sed -e 's/1, /1 /g' -e 's/0, /0 /g' -e 's/, [0-9]\{1,2\}\s/||/g' | tr '||' '\n' | tr ',' ' ' | sed -e '/^$/d'> 20_Ergebnisse_Vorrunde_${i}_format.txt

done
