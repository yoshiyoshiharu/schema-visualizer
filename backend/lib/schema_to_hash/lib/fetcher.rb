# frozen_string_literal: true

require_relative 'fetchers/schemas'
require_relative 'fetchers/tables'
require_relative 'fetchers/columns'

module SchemaToHash
  class Fetcher
    def initialize(db:)
      @db = db
    end

    def to_hash
      {
        tables: @table_list.to_hash,
        foreign_keys: @foreign_key_list.to_hash
      }
    end

    def schemas
      Fetchers::Schemas.new(db:).all
    end

    def tables(schema:)
      Fetchers::Tables.new(db:, schema:).all
    end

    private

    attr_reader :db
  end
end
