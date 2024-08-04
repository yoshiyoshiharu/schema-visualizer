# frozen_string_literal: true

module SchemaToHash
  class BaseFetcher
    def initialize(db:)
      @db = db
    end

    def schemas
      "#{fetcher_class}::Schemas".constantize.new(db:).all
    end

    def tables(schema_name:)
      "#{fetcher_class}::Tables".constantize.new(db:, schema_name:).all.map(&:to_h)
    end

    def columns(schema_name:, table_name:)
      "#{fetcher_class}::Columns".constantize.new(db:, schema_name:, table_name:).all.map(&:to_h)
    end

    def foreign_keys(schema_name:)
      "#{fetcher_class}::ForeignKeys".constantize.new(db:, schema_name:).all.map(&:to_h)
    end

    attr_reader :db

    private

    def fetcher_class
      "SchemaToHash::Fetchers::#{db.adapter.camelize}".constantize
    end
  end
end
