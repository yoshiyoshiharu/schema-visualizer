# frozen_string_literal: true

module SchemaToHash
  module Fetchers
    module Mysql
      class Schemas
        EXCEPT_SCHEMA = %w[
          information_schema
          performance_schema
          mysql
          sys
        ].freeze

        def initialize(db:)
          @db = db
        end

        def all
          db.exec(sql)
            .pluck('schema_name')
            .delete_if { |schema_name| EXCEPT_SCHEMA.any? { |keyword| schema_name.include?(keyword) } }
        end

        private

        attr_reader :db

        def sql
          <<-SQL.squish
            SELECT
              schema_name as schema_name
            FROM
              information_schema.schemata;
          SQL
        end
      end
    end
  end
end
