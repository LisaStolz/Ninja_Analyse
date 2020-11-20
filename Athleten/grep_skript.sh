#!/bin/sh

#grep -Po '(\d{6})' URL_Athleten.txt > URL_Bilder.txt

#for i in 16 17 18 19 20
#do
#grep -Po 'https://www.sport.de/ninja-warrior/pe[0-9]{6}/[^0-9]*/' ${i}_Athleten_Overview.txt > ${i}_Athleten_Detail_URL
#done


for i in 1 2 3 4 5 6
do
grep -A 10000 "Für mehr Daten, bitte Gerät drehen." $'20_Ergebnisse_Vorrunde_Show_'${i}'.txt' | tail -10000 | grep -B 10000 "Ninja Warrior Germany Mixed Ninja Warrior Germany Mixed" | head -10000 > 20_Ergebnisse_Vorrunde_${i}_short.txt
done
