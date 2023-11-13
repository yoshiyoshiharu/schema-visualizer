# frozen_string_literal: true

require_relative '../table'

module SchemaToHash
  module Fetchers
    class Tables
      def initialize(db:, schema_name:)
        @db = db
        @schema_name = schema_name
      end

      def all
        result = db.exec(sql)

        result.map do |row|
          Table.new(
            name: row['table_name'],
            comment: row['table_description'],
            columns: Columns.new(db:, schema_name:, table_name: row['table_name']).all
          )
        end
      end

      private

      attr_reader :db, :schema_name

      def sql
        <<-SQL
          SET search_path TO #{schema_name};

          SELECT
            table_name,
            obj_description(table_name::regclass) AS table_description
          FROM
            information_schema.tables
          WHERE
            table_schema = '#{schema_name}';
        SQL
      end
    end
  end
end
