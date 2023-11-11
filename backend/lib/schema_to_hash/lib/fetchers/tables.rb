# frozen_string_literal: true

require_relative '../table'

module SchemaToHash
  module Fetchers
    class Tables
      def initialize(db:, schema:)
        @db = db
        @schema = schema
      end

      def all
        result = db.exec(sql)

        result.map do |row|
          Table.new(
            name: row['table_name'],
            comment: row['table_description'],
            columns: Columns.new(db:, table_name: row['table_name']).all
          )
        end
      end

      private

      attr_reader :db, :schema

      def sql
        <<-SQL
          SET search_path TO #{schema};

          SELECT
            table_name,
            obj_description(table_name::regclass) AS table_description
          FROM
            information_schema.tables
          WHERE
            table_schema = '#{schema}';
        SQL
      end
    end
  end
end
