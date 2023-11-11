# frozen_string_literal: true

module Fetchers
  class Schema
    EXCEPT_SCHEMAS = %w[
      information_schema
      pg_catalog
      pg_toast
    ].freeze

    def initialize(db:)
      @db = db
    end

    def all
      result = @db.exec('SELECT schema_name FROM information_schema.schemata')
      result.map { |row| row['schema_name'] }.difference(EXCEPT_SCHEMAS)
    end
  end
end
