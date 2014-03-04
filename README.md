Read Me
======
*bundle install*

All test data files are located in the lib/challenge/data folder


Run with ./app
==============

./app -h for list of available commands
---------------------------------------


`    -h, --help                       help
    -i, --init [FILE]                Initialize Database from data folder or specified [FILE]
    -s field1 field2 reverse,        sort records by field, ordered by a second field, and call reverse on that second field
        --sort_by
    -a, --add LINE                   add ['Vader, Darth, M, Gray, 04-24-1300'] to database`


For example, sort with ./app -s "gender","dob","reverse"

Reinitialize the DB with ./app -i "path/to/file.txt" or leave blank to initialize from data folder

Add a line to the DB with:
*./app -a 'Vader, Darth, M, Gray, 04-24-1300'
*./app -a 'Cash | Johnnie | M | Grey | 06-01-1935'
*./app -a 'Swift Taylor F Orange 09-01-1992'


To Query VIA the Grape API
-----------------

`rackup config.ru`

To get records sorted by gender as JSON, pass field name as param:

`http://localhost:9292/records/gender`
`http://localhost:9292/records/dob`
`http://localhost:9292/records/last_name`

To get records sorted by gender, then sorted by date of birth as JSON, pass sort_by param:

`http://localhost:9292/records/gender?sort_by=dob`

To post to the database:

`POST http://localhost:9292/records/Swift%20Taylor%20F%20Orange%2009-01-1992`


