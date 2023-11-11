# frozen_string_literal: true

require_relative '../primary_key'

module SchemaToHash
  module Fetchers
    class PrimaryKeys
      def initialize(db:, schema_name:)
        @db = db
        @schema_name = schema_name
      end

      def all
        result = db.exec(sql)

        result.map do |row|
          ForeignKey.new(
            from_table_name: row['from_table_name'],
            from_column_name: row['from_column_name'],
            to_table_name: row['to_table_name']
          )
        end
      end

      private

      attr_reader :db, :schema_name

      def sql
        <<-SQL
          SELECT k.table_name AS from_table_name,
            k.column_name AS from_column_name,
            c.table_name AS to_table_name
          FROM
            information_schema.table_constraints as t,
            information_schema.key_column_usage as k,
            information_schema.constraint_column_usage as c
          WHERE
            t.constraint_type = 'FOREIGN KEY'
          AND
            t.constraint_name = k.constraint_name
          AND
            t.constraint_name = c.constraint_name
          AND
            t.table_schema = '#{schema_name}';
        SQL
      end
    end
  end
end
