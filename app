#!/usr/bin/env ruby
require 'optparse'
require "#{File.dirname(File.realpath(__FILE__))}/lib/dev_challenge.rb"

options = {}

opt_parser = OptionParser.new do |opt|
  opt.separator  ""
  opt.banner = "Dev Challenge:"
  opt.separator  "Commands"
  opt.separator  "     init['path/to/file']: initialize the database from data folder or specified file"
  opt.separator  "     sort_by ['field']: display records sorted by field or field1,field2 or field1,field2,reverse"
  opt.separator  "     add ['Vader, Darth, M, Gray, 04-24-1300']: add new  to database"
  opt.separator  "     rackup config.ru: run API server"
  opt.separator  "     help: show this message"
  opt.separator  ""
  opt.separator  "Options"

  opt.on("-h","--help","help") do
    puts opt_parser
  end

  opt.on("-i","--init [FILE]","Initialize Database from data folder or specified [FILE]") do |file|
    options[:file] = file || ''
    unless file.empty?
      options[:init] = true
      Database.initialize_database(file)
    else
      Database.initialize_database
    end

  end

  options[:fields] = []
  opt.on("-s", "--sort_by field1 field2 reverse", Array, "Sort records by FIELD, ordered by a second FIELD, and call REVERSE on that second field") do |fields|
      options[:fields] = fields
      Challenge.sort_people(fields[0],fields[1],fields[2])
      Challenge.print_people
  end

  opt.on("-a","--add LINE","add line to db") do |line|
    options[:line] = line
    Challenge.add_line(line)
    Challenge.print_people
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
