# frozen_string_literal: true

require_relative 'scanner'

if ARGV.length == 0
  puts 'Usage: ruby main.rb <schema_text>'
  exit
end

if __FILE__ == $0
  schema_text = ARGV[0]

  schema = Scanner.new(schema_text).generate_table_list.to_hash
  pp schema
end
