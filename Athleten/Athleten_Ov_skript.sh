#!/bin/sh

for i in 16 17 18 19
do
sed -e 's@image-"><a href="@https://www.sport.de@' -e 's/alt=//g' -e '/^[0-9c]*$/d' -e 's/"//g'  ${i}_Athleten_Infos_short.txt | sed -e ':a;N;$!ba;s/\n/, /g' | sed -e 's/, https/\nhttps/g' | sed -e '/[, ]$/d' > ${i}_Athleten_Overview.txt
done
