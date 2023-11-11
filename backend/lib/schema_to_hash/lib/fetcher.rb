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
      schemas.map do |schema|
        {
          schema:,
          tables: tables(schema_name: schema).map(&:to_hash)
        }
      end
    end

    private

    def schemas
      Fetchers::Schemas.new(db:).all
    end

    def tables(schema:)
      Fetchers::Tables.new(db:, schema:).all
    end

    attr_reader :db
  end
end
