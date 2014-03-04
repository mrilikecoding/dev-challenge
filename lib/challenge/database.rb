module Database

	# config
	@data_directory = Dir["../data/*.*"]
	$database_file = "db.csv"
	

	def self.open_db
		@db = File.open($database_file, "a")	
	end


	def self.close_db
		# @db.close()
	end

	def self.get_db
		File.open($database_file, "a")
	end

	# set database source files and call write
	def self.initialize_database(*data_source_file)
		Database.open_db
		data_source_file.present? ? write_database(@db, data_source_file) : write_database(@db, @data_directory)
		Database.close_db
	end

	# append one line to the db
	def self.add_line(line)
		Database.open_db
		parsed_line = line.gsub(/\,\s/, ' ').gsub(/\|\s/, "")
		@db << "\n#{parsed_line}".gsub('"', '')
		Database.close_db
	end

	# write specified files to db file
	def self.write_database(database_file, data_directory)
		@db.truncate(0)
		puts "generating data from #{data_directory}"		
		data_directory.each_with_index do |file, file_index|
			puts "file accessed..."
			target_file = File.open(file, "r") do |t|
				File.readlines(t).each_with_index do |line, line_index|
					line = line.gsub(/\,\s/, ' ').gsub(/\|\s/, "")
					if file_index == 0 && line_index == 0
						database_file << line
					elsif line_index == 0 && file_index > 0
						database_file <<  "\n"
					elsif line_index > 0
						database_file << line
					end
				end
			end
		end
		puts "data written successfully!"
	end

	def self.get_lines
		Database.open_db
		File.readlines(@db).each_with_index do |line, index|
			yield line, index
		end
		Database.close_db
	end

end