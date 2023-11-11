# frozen_string_literal: true

require_relative 'fetchers/schemas'
require_relative 'fetchers/tables'
require_relative 'fetchers/columns'

module SchemaToHash
  class Fetcher
    def initialize(db:)
      @db = db
    end

    def execute
      schemas.map do |schema_name|
        {
          schema: schema_name,
          tables: tables(schema_name:).map(&:to_hash)
        }
      end
    end

    private

    def schemas
      Fetchers::Schemas.new(db:).all
    end

    def tables(schema_name:)
      Fetchers::Tables.new(db:, schema_name:).all
    end

    attr_reader :db
  end
end
