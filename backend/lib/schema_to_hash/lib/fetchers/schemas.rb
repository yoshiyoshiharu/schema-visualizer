# frozen_string_literal: true

module SchemaTohas
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
        result = db.exec(sql)
        result.map { |row| row['schema_name'] }.difference(EXCEPT_SCHEMAS)
      end

      private

      attr_reader :db

      def sql
        <<-SQL
          SELECT
            schema_name
          FROM
            information_schema.schemata;
        SQL
      end
    end
  end
end
