$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/../lib")

require 'rubygems' 
require 'bundler/setup'
require 'rack'
require 'grape'
require 'json'

require "challenge/api"
require "challenge/database"
require "challenge/people"


module Challenge

	@people = []
	@db = Database.get_db

	def self.create_people
		@people = People.populate(@db, @people)
	end

	def self.sort_people(*field)
		@people = Challenge.create_people
		puts "#{@people.size} people detected"
		sorted = People.sort_people(field[0],field[1],field[2], @people)
		puts "sorted #{sorted.size} people!"
		return sorted
	end

	def self.print_people
		Challenge.create_people
		puts "printing..."
		@people.each do |p|
			puts "Name: #{p[:first_name]} #{p[:last_name]}, Gender: #{p[:gender]}, Favorite Color: #{p[:fav_color]}, DOB: #{p[:dob].strftime('%m/%d/%Y')}"
		end	
	end


	def self.add_line(line)
		Database.open
		Database.add_line(line)
		Database.close
	end

end


# Database.initialize_database
# Challenge.sort_people("gender", "dob", "reverse")
# Database.add_line('Hamm, Jon, M, Blue, 04-24-1968')
# Challenge.print_people	


