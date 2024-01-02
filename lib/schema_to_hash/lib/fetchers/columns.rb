# frozen_string_literal: true

require_relative '../column'
require_relative 'primary_keys'

module SchemaToHash
  module Fetchers
    class Columns
      def initialize(db:, schema_name:, table_name:)
        @db = db
        @schema_name = schema_name
        @table_name = table_name
        @primary_keys = PrimaryKeys.new(db:, schema_name:).all
      end

      def all
        db.exec(sql).map do |row|
          Column.new(
            name: row['column_name'],
            default: row['column_default'],
            nullable: row['is_nullable'] == 'YES',
            type: row['data_type'],
            comment: row['column_description'],
            primary_key: primary_key?(row)
          )
        end
      end

      private

      attr_reader :db, :schema_name, :table_name, :primary_keys

      def primary_key?(row)
        primary_keys.any? do |pk|
          pk.table_name == table_name && pk.column_name == row['column_name']
        end
      end

      def sql
        <<-SQL
          SELECT
            table_schema,
            table_name,
            column_name,
            column_default,
            is_nullable,
            data_type,
            col_description(table_name::regclass, ordinal_position) AS column_description
          FROM
            information_schema.columns
          WHERE
            table_name = '#{table_name}'
          AND
            table_schema = '#{schema_name}'
          ORDER BY
            ordinal_position;
        SQL
      end
    end
  end
end
