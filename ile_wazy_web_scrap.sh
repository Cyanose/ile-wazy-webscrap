#!/bin/sh
# The script curl the site given as the parameter, extracts the most 
#important macronutrients and insersts this infos to the database 
file=$(echo $1 | sed 's|http://www.ilewazy.pl/||g; s/-/_/g')
db="$PWD/ile_wazy.db"
echo $file

curl $1 | pup "#ilewazy-ingedients > tbody text{}" | sed -r '/^\s*$/d; s/,/./g' | awk '{print $1}' > $file 

kcal=$(grep -A 1 "Energia" $file | tail -1)
carbs=$(grep -A 1 "glowodany$" $file | tail -1)
proteins=$(grep -A 1 "Bia*" $file | tail -1)
fats=$(grep -A 1 "uszcz$" $file | tail -1)

sqlite3 $db "insert into food (name,kcal,carbs,proteins,fats) 
values ('${file}',$kcal,$carbs,$proteins,$fats);"
rm $file

echo " "
echo kcal: $kcal
echo proteins: $proteins
echo fats: $fats
echo carbs: $carbs
