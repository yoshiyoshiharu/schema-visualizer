# frozen_string_literal: true

require_relative 'scanner'

if ARGV.length != 1
  puts 'Usage: ruby main.rb <schema_text>'
  exit
end

if __FILE__ == $PROGRAM_NAME
  file_path = ARGV[0]

  schema_hash = SchemaToHash::Scanner.new(File.read(file_path)).generate_table_list.to_hash
  pp schema_hash
end
