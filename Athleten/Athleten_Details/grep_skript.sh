#!/bin/sh

#grep -Po '(\d{6})' URL_Athleten.txt > URL_Bilder.txt

#for i in 16 17 18 19 20
#do
#grep -Po 'https://www.sport.de/ninja-warrior/pe[0-9]{6}/[^0-9]*/' ${i}_Athleten_Overview.txt > ${i}_Athleten_Detail_URL
#done


for file in /home/lisa/DataScience/Ninja_Projekt/Athleten/Athleten_Details/html_Detail/*
do
    #grep -A 10000 '<script src="https://sourcepoint.sport.de/wrapperMessagingWithoutDetection.js"></script>' $file | tail -10000 | grep -B 10000 '/* global detectMobile */' | head -10000 >> results.txt
    grep -Po '"Person","name":"(.*)"' $file >> result.txt
done
