#!/bin/sh

delete_shitty_links () {
sed -i '/zaloguj/d' $1
sed -i '/zarejestruj/d' $1
sed -i '/uwagi/d' $1
sed -i '/regulamin/d' $1
sed -i '/o-stronie/d' $1
sed -i '/kategoria/d' $1
sed -i '/dziennik/d' $1
sed -i '/img/d' $1
sed -i '/edi/d' $1
sed -i '/-$/d' $1 #delete all broken food links
sed -i '/.pl$/d' $1 #delete homepage link
}

# the whole ilewazy database contains 351 pages
# in case the script bugs, just list the current directory, and see 
# what is the number in the name of linksPage(num) file and modify 
# the first parameter of the seq command below to be that number + 1 
for pageNum in $(seq 1 1 351)
do
	site=($(sed '1q;d' conf)${pageNum})
	curl $site | html2text | grep -Eo "(http)://[a-zA-Z0-9./?=_%:-]*" | sort -u > linksPage${pageNum}
	delete_shitty_links linksPage${pageNum}
	end=$(wc -l < linksPage${pageNum})
	for lines in $(seq 1 1 $end)
		do
		# here the script extracting values will run multiple times parsing arguments from the linksPage temporary file 
		./ile_wazy_web_scrap.sh $(sed "${lines}q;d" linksPage${pageNum})
		done
	rm linksPage${pageNum}
done
