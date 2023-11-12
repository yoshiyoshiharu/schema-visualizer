# frozen_string_literal: true

require_relative '../schema_to_hash/schema_to_hash'

namespace :tables do
  desc 'Create tables'
  task create: :environment do
    schema_to_hash = SchemaToHash.new(schema)

    pp schema_to_hash.schemas
    pp schema_to_hash.tables
    pp schema_to_hash.foreign_keys
  end

  def log(text)
    puts text
  end
end
