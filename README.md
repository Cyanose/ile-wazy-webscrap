# ile-wazy-webscrap

Simple shell scripts to web scrap product's most essential macronutrients such as: kcal, carbs, proteins, fats from the ilewazy site, and insert them to your own local sqlite database. 

## Usage

run command: `sqlite3 ilewazy.db 'create table food(name text PRIMARY KEY, kcal real, carbs real, proteins real, fats real);'`. This will create create the table into which the script will be inserting informations about the products.

Just run `./ile_wazy_web_scrap.sh` script to start scraping the ilewazy.pl product base. If you want to insert only the particular product from the ilewazy.pl site, run `./web_scrap_db.sh` passing the link to the exact ilewazy.pl page that you want scrap.

In case the script bugs, you will find the *linksPage(NUM)* file in the current directory, It's name indicates parsing 



