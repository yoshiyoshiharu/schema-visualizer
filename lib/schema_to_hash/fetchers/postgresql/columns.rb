# frozen_string_literal: true

module SchemaToHash
  module Fetchers
    module Postgresql
      class Columns
        def initialize(db:, schema_name:, table_name:)
          @db = db
          @schema_name = schema_name
          @table_name = table_name
        end

        def all
          db.exec(sql).map do |row|
            Struct.new(:name, :default, :nullable, :type, :comment, :primary_key).new(
              name: row['column_name'],
              default: row['column_default'],
              nullable: row['is_nullable'] == 'YES',
              type: row['data_type'],
              comment: row['column_description'],
              primary_key: row['is_primary_key'] == 'YES'
            )
          end
        end

        private

        attr_reader :db, :schema_name, :table_name

        # rubocop:disable Metrics/MethodLength
        def sql
          <<-SQL.squish
            SELECT
              columns.column_name,
              columns.column_default,
              columns.is_nullable,
              columns.data_type,
              col_description(columns.table_name::regclass, columns.ordinal_position) AS column_description,
              CASE WHEN table_constraints.constraint_type = 'PRIMARY KEY' THEN 'YES' END AS is_primary_key
            FROM
              information_schema.columns as columns
            LEFT JOIN information_schema.key_column_usage as key_column_usage
              ON columns.column_name = key_column_usage.column_name
              AND columns.table_name = key_column_usage.table_name
              AND columns.table_schema = key_column_usage.table_schema
            LEFT JOIN information_schema.table_constraints as table_constraints
              ON key_column_usage.constraint_name = table_constraints.constraint_name
              AND columns.table_name = table_constraints.table_name
              AND columns.table_schema = table_constraints.table_schema
            WHERE
              columns.table_name = '#{table_name}'
            AND
              columns.table_schema = '#{schema_name}'
            ORDER BY
              columns.ordinal_position;
          SQL
        end
        # rubocop:enable Metrics/MethodLength
      end
    end
  end
end
