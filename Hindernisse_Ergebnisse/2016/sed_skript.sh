#!/bin/sh

for i in 1 2 3 4
do
sed -e '/Deutschland/d' -e '/Österreich/d' -e '/Schweiz/d' -e '/Ninja Warrior Germany Mixed Ninja Warrior Germany Mixed/d' -e '/Für mehr Daten, bitte Gerät drehen/d' -e 's@<.*>@ @' -e '/^\s*[A-Z]./d' 16_Ergebnisse_Vorrunde_${i}_short.txt | sed -e ':a;N;$!ba;s/\n/, /g' | sed -e 's/1, /1 /g' -e 's/0, /0 /g' -e 's/, [0-9]\{1,2\}\s/||/g' | tr '||' '\n' | tr ',' ' ' | sed -e '/^$/d'> 16_Ergebnisse_Vorrunde_${i}_format.txt

done

for i in 1 2 3 4
do
sed -e '/Deutschland/d' -e '/Österreich/d' -e '/Schweiz/d' -e '/Ninja Warrior Germany Mixed Ninja Warrior Germany Mixed/d' -e '/Für mehr Daten, bitte Gerät drehen/d' -e 's@<.*>@ @' -e '/^\s*[A-Z]./d' 16_Ergebnisse_HalbfinalQuali_${i}_short.txt | sed -e ':a;N;$!ba;s/\n/, /g' | sed -e 's/1, /1 /g' -e 's/0, /0 /g' -e 's/, [0-9]\{1,2\}\s/||/g' | tr '||' '\n' | tr ',' ' ' | sed -e '/^$/d'> 16_Ergebnisse_HalbfinalQuali_${i}_format.txt

done

sed -e '/Deutschland/d' -e '/Österreich/d' -e '/Schweiz/d' -e '/Ninja Warrior Germany Mixed Ninja Warrior Germany Mixed/d' -e '/Für mehr Daten, bitte Gerät drehen/d' -e 's@<.*>@ @' -e '/^\s*[A-Z]./d' 16_Ergebnisse_Finale_1_short.txt | sed -e ':a;N;$!ba;s/\n/, /g' | sed -e 's/1, /1 /g' -e 's/0, /0 /g' -e 's/, [0-9]\{1,2\}\s/||/g' | tr '||' '\n' | tr ',' ' ' | sed -e '/^$/d'> 16_Ergebnisse_Finale_1_format.txt

sed -e '/Deutschland/d' -e '/Österreich/d' -e '/Schweiz/d' -e '/Ninja Warrior Germany Mixed Ninja Warrior Germany Mixed/d' -e '/Für mehr Daten, bitte Gerät drehen/d' -e 's@<.*>@ @' -e '/^\s*[A-Z]./d' 16_Ergebnisse_Finale_2_short.txt | sed -e ':a;N;$!ba;s/\n/, /g' | sed -e 's/1, /1 /g' -e 's/0, /0 /g' -e 's/, [0-9]\{1,2\}\s/||/g' | tr '||' '\n' | tr ',' ' ' | sed -e '/^$/d'> 16_Ergebnisse_Finale_2_format.txt
