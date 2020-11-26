#!/bin/sh

#grep -Po '(\d{6})' URL_Athleten.txt > URL_Bilder.txt

#for i in 16 17 18 17 20
#do
#grep -Po 'https://www.sport.de/ninja-warrior/pe[0-9]{6}/[^0-9]*/' ${i}_Athleten_Overview.txt > ${i}_Athleten_Detail_URL
#done


for i in 1 2 3 4 5 6 7
do
grep -A 10000 "Für mehr Daten, bitte Gerät drehen." 17_Ergebnisse_Vorrunde_Show_${i}.txt | tail -10000 | grep -B 10000 "Ninja Warrior Germany Mixed Ninja Warrior Germany Mixed" | head -10000 > 17_Ergebnisse_Vorrunde_${i}_short.txt
done

for i in 1 2 3 4 5 6 7
do
grep -A 10000 "Für mehr Daten, bitte Gerät drehen." 17_Ergebnisse_HalbfinalQuali_Show_${i}.txt | tail -10000 | grep -B 10000 "Ninja Warrior Germany Mixed Ninja Warrior Germany Mixed" | head -10000 > 17_Ergebnisse_HalbfinalQuali_${i}_short.txt
done

grep -A 10000 "Für mehr Daten, bitte Gerät drehen." 17_Ergebnisse_Halbfinale.txt | tail -10000 | grep -B 10000 "Ninja Warrior Germany Mixed Ninja Warrior Germany Mixed" | head -10000 > 17_Ergebnisse_Halbfinale_short.txt

grep -A 10000 "Für mehr Daten, bitte Gerät drehen." 17_Ergebnisse_Finale1.txt | tail -10000 | grep -B 10000 "Ninja Warrior Germany Mixed Ninja Warrior Germany Mixed" | head -10000 > 17_Ergebnisse_Finale1_short.txt

grep -A 10000 "Für mehr Daten, bitte Gerät drehen." 17_Ergebnisse_Finale2.txt | tail -10000 | grep -B 10000 "Ninja Warrior Germany Mixed Ninja Warrior Germany Mixed" | head -10000 > 17_Ergebnisse_Finale2_short.txt

grep -A 10000 "Für mehr Daten, bitte Gerät drehen." 17_Ergebnisse_Finale3.txt | tail -10000 | grep -B 10000 "Ninja Warrior Germany Mixed Ninja Warrior Germany Mixed" | head -10000 > 17_Ergebnisse_Finale3_short.txt

