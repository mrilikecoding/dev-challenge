require 'rubygems' 
require 'bundler/setup'
require 'rack'
require 'grape'
require 'json'

# locate the db file
$db = 'db.csv'

module DevChallenge
	
	# define our data model
	Person = Struct.new(:last_name, :first_name, :gender, :fav_color, :dob)

	def self.init_db(*source_file)
		puts "this will overwrite the current db if it exists. continue? (y/n)"
		response = STDIN.gets.chomp()
		if response == "y"
			write_db($db, source_file)
			puts "database initialized!"
		else
			puts "database not initialize"
		end
	end

	# take user file or grab files from data folder and write to db file
	def self.write_db(db_file, *data_source_file)
		puts "initializing..."
		db = File.open(db_file, "a")
		db.truncate(0)
		
		unless data_source_file[0].empty?
			files = data_source_file[0]
			puts "generating from #{data_source_file[0][0]}..."
		else 
			files = Dir["data/*.*"]
			puts "no source file specified, generating from data folder..." 
			puts "files : #{Dir["data/*.*"]}"
		end

		files.each_with_index do |file, file_index|
			puts "file accessed..."
			target = File.open(file, "r") do |t|
				File.readlines(t).each_with_index do |line, line_index|
					line = line.gsub(/\,\s/, ' ').gsub(/\|\s/, "")
					if file_index == 0 && line_index == 0
						db << line
					elsif line_index > 0
						db << line
					end
				end
			end
		end

		db.close()
	end

	#append a line to db file
	def self.append_to_db(line)
		db = File.open($db, "a")
		parsed_line = line.gsub(/\,\s/, ' ').gsub(/\|\s/, "")
		db << "\n#{parsed_line}".gsub('"', '')
		puts "Posted: #{parsed_line}"
		db.close()
	end

	#parse db file rows into an array of Person objects as defined above
	def self.db_to_arr
		people = []
		db = File.open($db, "r")
		File.readlines(db).each_with_index do |line, index|
			if index > 0
				fields = line.split(" ")
				p = Person.new
				p.last_name = fields[0]
				p.first_name = fields[1]
				p.gender = fields[2]
				p.fav_color = fields[3]
				p.dob = DateTime.strptime(fields[4],'%m-%d-%Y')
				people.push(p)
			end
		end
		db.close()
		people
	end


	# sort people array by field and print to console
	# take second argument as a secondary filter and a third reverse parameter
	def self.sort_by(*field)
		people = self.db_to_arr

		field1 = field[0]	
		field2 = field[1] || false
		reverse = field[2] || false

		if field1.present? && field2 == false
			people.sort_by! {|f1| f1[field1]}
		elsif field1.present? && field2.present?
			if reverse.present? && reverse == "reverse"
				people.sort! do |f1, f2|
					[f1[field1],f2[field2]] <=> [f2[field1], f1[field2]] 
				end
			else
				people.sort_by! do |f1| 
					[f1[field1], f1[field2]]
				end
			end
		end
		
		people.each do |p|
			puts "Name: #{p.first_name} #{p.last_name}, Gender: #{p.gender}, Favorite Color: #{p.fav_color}, DOB: #{p.dob.strftime('%m/%d/%Y')}"
		end		
	end

	#sort people array by field and return new array
	def self.get_sort_by(*field)
		people = self.db_to_arr

		field1 = field[0]	
		field2 = field[1] || false
		
		if field1.present? && field2 == false
			people.sort_by! {|f1| f1[field1]}
		elsif field1.present? && field2.present?
			people.sort_by! do |f1| 
				[f1[field1], f1[field2]]
			end
		end

		all_people= []
		
		people.each_with_index do |p, i|
			records = {}
			records[:first_name] = p.first_name
			records[:last_name] = p.last_name
			records[:gender] = p.gender
			records[:fav_color] = p.fav_color
			records[:dob] = p.dob.strftime('%m/%d/%Y')
			all_people[i] = records
		end

		all_people 

	end

end

# API for getting records sorted by field and posting lines
class API < Grape::API
	format :json

	post 'records/:line' do
		puts "post request"
		line = params[:line]
		DevChallenge.append_to_db(line)
	end

	get 'records/:primary_field' do
		primary_field = params[:primary_field]
		DevChallenge.get_sort_by(primary_field, *params[:sort_by])
	end

end

# command line args
if ARGV[0] == "init_db"
	DevChallenge.init_db(*ARGV[1])
elsif ARGV[0] == "sort_by" && ARGV[1].present?
	DevChallenge.sort_by(ARGV[1], *ARGV[2], *ARGV[3])
elsif ARGV[0] == "add_line" && ARGV[1].present?
	DevChallenge.append_to_db(ARGV[1])
else
	puts "Yo! Pass argument 'init_db' to reset database and compile from data folder, or return existing db records sorted by passing in 'sort_by' plus 'field'. More info can be found in the ReadMe."
end



