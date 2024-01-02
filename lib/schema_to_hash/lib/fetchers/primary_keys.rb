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
          PrimaryKey.new(
            table_name: row['table_name'],
            column_name: row['column_name']
          )
        end
      end

      private

      attr_reader :db, :schema_name

      def sql
        <<-SQL.squish
          SELECT
            k.table_name,
            k.column_name
          FROM
            information_schema.table_constraints as t,
            information_schema.key_column_usage as k
          WHERE
            t.constraint_type = 'PRIMARY KEY'
          AND
            t.constraint_name = k.constraint_name
          AND
            t.table_schema = '#{schema_name}';
        SQL
      end
    end
  end
end
