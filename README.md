ReadMe
======
*create an rvm gemset and bundle install*

All test db files are located in the data folder

To generate the 'database' from the data folder, run the following command:

`ruby dev_challenge.rb init_db`

To pass in your own file, run:

`ruby dev_challenge.rb init_db "path/to/file.txt"`

To print out records sorted by gender:

`ruby dev_challenge.rb sort_by gender`

To print out records sorted by gender, then sorted by date of birth:

`ruby dev_challenge.rb sort_by gender dob`

To print out records sorted by gender, then reverse sorted by date of birth:

`ruby dev_challenge.rb sort_by gender dob reverse`

To add a line to the database:

`ruby dev_challenge.rb add_line "Costas | Bob | M | Pink | 03-21-1954"`

VIA the Grape API
-----------------

`rackup config.ru`

To get records sorted by gender as JSON, pass field name as param:

`http://localhost:9292/records/gender`
`http://localhost:9292/records/dob`
`http://localhost:9292/records/last_name`


To get records sorted by gender, then sorted by date of birth as JSON, pass sort_by param:

`http://localhost:9292/records/gender?sort_by=dob`

To post to the database:

`POST http://localhost:9292/records/Cash%20John%20M%20Black%2003-21-1954`


