# ile-wazy-webscrap

Simple shell scripts to web scrap product's most essential macronutrients such as: kcal, carbs, proteins, fats from the ilewazy site, and insert them to your own local sqlite database. 

## Usage

run command: `sqlite3 ilewazy.db 'create table food(name text PRIMARY KEY, kcal real, carbs real, proteins real, fats real);'`. This will create create the table into which the script will be inserting informations about the products.



