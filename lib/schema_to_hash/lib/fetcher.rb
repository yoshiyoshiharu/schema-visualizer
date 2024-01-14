# frozen_string_literal: true

require_relative 'fetchers/schemas'
require_relative 'fetchers/tables'
require_relative 'fetchers/columns'
require_relative 'fetchers/primary_keys'
require_relative 'fetchers/foreign_keys'

module SchemaToHash
  class Fetcher
    def initialize(db:)
      @db = db
    end

    def schemas
      Fetchers::Schemas.new(db:).all
    end

    def tables(schema_name:)
      Fetchers::Tables.new(db:, schema_name:).all.map(&:to_hash)
    end

    def columns(schema_name:, table_name:)
      Fetchers::Columns.new(db:, schema_name:, table_name:).all.map(&:to_hash)
    end

    def foreign_keys(schema_name:)
      Fetchers::ForeignKeys.new(db:, schema_name:).all.map(&:to_hash)
    end

    attr_reader :db
  end
end
