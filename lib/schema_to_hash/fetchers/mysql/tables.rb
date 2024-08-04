# frozen_string_literal: true

module SchemaToHash
  module Fetchers
    module Mysql
      class Tables
        def initialize(db:, schema_name:)
          @db = db
          @schema_name = schema_name
        end

        def all
          db.exec(sql).map do |row|
            Struct.new(:name, :comment).new(
              name: row['table_name'],
              comment: row['table_comment']
            )
          end
        end

        private

        attr_reader :db, :schema_name

        def sql
          <<-SQL.squish
            SELECT
              table_name as table_name,
              table_comment as table_comment
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
