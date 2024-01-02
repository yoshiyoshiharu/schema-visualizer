# frozen_string_literal: true

module SchemaToHash
  module Fetchers
    class Schemas
      EXCEPT_SCHEMA_KEYWORDS = %w[
        information_schema
        pg_catalog
        pg_toast
        pg_temp
      ].freeze

      def initialize(db:)
        @db = db
      end

      def all
        result = db.exec(sql)
        result.pluck('schema_name')
              .delete_if { |schema_name| EXCEPT_SCHEMA_KEYWORDS.any? { |keyword| schema_name.include?(keyword) } }
      end

      private

      attr_reader :db

      def sql
        <<-SQL.squish
          SELECT
            schema_name
          FROM
            information_schema.schemata;
        SQL
      end
    end
  end
end
