# frozen_string_literal: true

module SchemaToHash
  module Fetchers
    module Mysql
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
              type: row['column_type'],
              comment: row['column_comment'],
              primary_key: row['column_key'] == 'PRI'
            )
          end
        end

        private

        attr_reader :db, :schema_name, :table_name

        # rubocop:disable Metrics/MethodLength
        def sql
          <<-SQL.squish
            SELECT
              column_name as column_name,
              column_default as column_default,
              is_nullable as is_nullable,
              column_type as column_type,
              column_comment as column_comment,
              column_key as column_key
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
        # rubocop:enable Metrics/MethodLength
      end
    end
  end
end
