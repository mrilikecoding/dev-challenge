ReadMe
======
*create an rvm gemset and bundle install*

All test db files are located in the lib/challenge/data folder


Run with ./app

==============
./app -h for list of available commands
---------------------------------------


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


