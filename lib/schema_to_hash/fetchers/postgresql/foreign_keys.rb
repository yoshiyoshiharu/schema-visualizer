# frozen_string_literal: true

module SchemaToHash
  module Fetchers
    module Postgresql
      class ForeignKeys
        def initialize(db:, schema_name:)
          @db = db
          @schema_name = schema_name
          @schema_oid = set_schema_oid
        end

        def all
          db.exec(sql).map do |row|
            Struct.new(:from_table_name, :from_column_name, :to_table_name).new(
              from_table_name: row['from_table_name'],
              from_column_name: row['from_column_name'],
              to_table_name: row['to_table_name']
            )
          end
        end

        private

        attr_reader :db, :schema_name, :schema_oid

        # rubocop:disable Metrics/MethodLength
        def sql
          <<-SQL.squish
            SELECT
              replace(pg_constraint.conrelid::regclass::text, '#{schema_name}.', '') AS from_table_name,
              pg_attribute.attname AS from_column_name,
              replace(pg_constraint.confrelid::regclass::text, '#{schema_name}.', '') AS to_table_name
            FROM
              pg_constraint
            INNER JOIN pg_attribute
              ON pg_constraint.conrelid = pg_attribute.attrelid AND pg_attribute.attnum = ANY(pg_constraint.conkey)
            WHERE
              contype = 'f'
            AND
              connamespace = '#{schema_oid}';
          SQL
        end
        # rubocop:enable Metrics/MethodLength

        def set_schema_oid
          db.exec("SELECT oid FROM pg_namespace WHERE nspname = '#{schema_name}'").first['oid']
        end
      end
    end
  end
end
