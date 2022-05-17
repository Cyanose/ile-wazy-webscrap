#!/bin/bash
# The script curl the site given as the parameter, extracts the most 
#important macronutrients and insersts formated values to the database 
db="$PWD/ile_wazy.db"

file=$(echo $1 | sed 's|http://www.ilewazy.pl/||g' | sed 's/-/_/g')
curl $1 | html2text > $file
begin=$(grep -n "Energia " $file | cut -f1 -d:)
begin=$(( $begin - 1 ))
sed -i $file -re "1,${begin}d"
end=$(grep -n "Błonnik " $file | cut -f1 -d:)
sed -i $file -re "${end},\$d"
sed -i '/Kwasy tłuszczowe nasycone/d' $file
sed -i '/Cukry proste/d' $file
sed -i 's/,/./g' $file
sed -i 's/Energia |  //g' $file

#extracting values 
kcal=$(cut -c 1-3 < $file | head -1)
proteins=$(grep -oE "([0-9]\.[0-9].g..\|)" $file | sed 's/.g..|//' | sed '1q;d')
fats=$(grep -oE "([0-9]\.[0-9].g..\|)" $file | sed 's/.g..|//' | sed '2q;d')
carbs=$(grep -oE "([0-9]\.[0-9].g..\|)" $file | sed 's/.g..|//' | sed '3q;d')
#inserting values into sqlite database
sqlite3 $db "insert into food (name,kcal,carbs,proteins,fats) 
values ('${file}',$kcal,$carbs,$proteins,$fats);"
rm $file
# print the extracted values
echo " "
echo "name: $file"
echo "kcal: $kcal"
echo "proteins: ${proteins}"
echo "fats: ${fats}"
echo "carbs: ${carbs}"
