require './lib/dev_challenge'

puts "visit localhost:9292/records/:field_name ie gender, dob"
puts "visit /records/:field_name?sort_by=dob to add secondary sort"

run API.new