# frozen_string_literal: true

module SchemaToHash
  module Fetchers
    module Mysql
      class ForeignKeys
        def initialize(db:, schema_name:)
          @db = db
          @schema_name = schema_name
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

        attr_reader :db, :schema_name

        # rubocop:disable Metrics/MethodLength
        def sql
          <<-SQL.squish
            SELECT
              k.table_name AS from_table_name,
              k.column_name AS from_column_name,
              k.referenced_table_name AS to_table_name
            FROM
              information_schema.table_constraints AS t
            JOIN
              information_schema.key_column_usage AS k ON t.constraint_name = k.constraint_name
            WHERE
              t.constraint_type = 'FOREIGN KEY'
            AND
              t.table_schema = '#{schema_name}';
          SQL
        end
        # rubocop:enable Metrics/MethodLength
      end
    end
  end
end
