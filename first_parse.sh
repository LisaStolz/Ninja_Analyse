#!/bin/sh

for i in {16..19}
do
    grep -Po '((alt=|image-"><a href=)"(.*?)"|(\d\d.\d\d.\d\d\d\d))' ${i}_Athleten_Infos.txt > ${i}_Athleten_Infos_short.txt
done
