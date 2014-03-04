#!/usr/bin/env ruby
require 'optparse'
require "#{File.dirname(File.realpath(__FILE__))}/lib/dev_challenge.rb"

options = {}

opt_parser = OptionParser.new do |opt|
  opt.banner = "Dev Challenge:"
  opt.separator  "Options"
  opt.on("-h","--help","help") do
    puts opt_parser
  end

  opt.on("-i","--init [FILE]","Initialize Database from data folder or specified [FILE]") do |file|
    options[:file] = file || ''
    if file.present?
      Database.initialize_database(file)
    else
      Database.initialize_database
      #options[:init] = true
    end

  end

  options[:fields] = []
  opt.on("-s", "--sort_by field1 field2 reverse", Array, "sort records by field, ordered by a second field, and call reverse on that second field") do |fields|
      options[:fields] = fields
      @people = Challenge.sort_people(fields[0],fields[1],fields[2])
      Challenge.print_people(@people)
  end

  opt.on("-a","--add LINE","add ['Vader, Darth, M, Gray, 04-24-1300'] to database") do |line|
    options[:line] = line

    Database.add_line(line)
    @people = Challenge.create_people
    Challenge.print_people(@people)
  end

end

opt_parser.parse!

case ARGV[0]
when "init_db"
  puts "initialize the database #{options.inspect}"
when "sort_by"
  puts "sort by field #{options.inspect}"
when "add_line"
  puts "add line to db #{options.inspect}"
else
  puts opt_parser
end
