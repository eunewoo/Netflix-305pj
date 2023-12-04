# CSE305 Database course Final Project

## Team name: Filmnest

## Collaborators: Biniam Markos, Eunwoo Choi, Ulukbek Atimatov

## Used language
Java(JSP, JDBC)
MySQL

### Setup Guideline 
#### Database setup terminal command
sudo mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS filmnestdb"
sudo mysql -u root -p filmnestdb < filmnestdb.sql

Change db, owner, password of each function in DAO files into your one.
Follow comment to how each function is related to each button.

#### GUI, JSP improvements
-Changed colors and box alignments which seems like Netflix
-Insert mockup image for movie to make it more like movie rental site
-Add login schema, fix java file to rightly pass logged in data in controller

#### SampleID for test
Manager - Manage Employee, See overall sales and revenue
ID: admin@example.com
PW: abc123

Customer Representative - View and Manage Customer
ID: person2@example.com
PW: abc123

Customer - Look up rent history and deal with profiles
ID: person3@example.com
PW: abc123
