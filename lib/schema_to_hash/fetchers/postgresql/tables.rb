# frozen_string_literal: true

module SchemaToHash
  module Fetchers
    module Postgresql
      class Tables
        def initialize(db:, schema_name:)
          @db = db
          @schema_name = schema_name
        end

        def all
          db.exec(sql).map do |row|
            Struct.new(:name, :comment).new(
              name: row['table_name'],
              comment: row['table_description']
            )
          end
        end

        private

        attr_reader :db, :schema_name

        def sql
          <<-SQL.squish
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
end
