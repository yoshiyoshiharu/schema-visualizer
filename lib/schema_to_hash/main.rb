# frozen_string_literal: true

require_relative 'scanner'

if ARGV.length != 1
  puts 'Usage: ruby main.rb <schema_text>'
  exit
end

if __FILE__ == $0
  schema_text = ARGV[0]

  schema_hash = SchemaToHash::Scanner.new(schema_text).generate_table_list.to_hash
  pp schema_hash
end
