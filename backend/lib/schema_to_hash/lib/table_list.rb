# frozen_string_literal: true

module SchemaToHash
  class TableList
    attr_reader :tables

    def initialize(tables = [])
      @tables = tables
    end

    def add(table)
      @tables << table
    end

    def find_table_by_name(name)
      @tables.find { |table| table.name == name }
    end

    def to_hash
      tables.map do |table|
        {
          name: table.name,
          comment: table.comment,
          columns: table.columns.map do |column|
            {
              name: column.name,
              type: column.type,
              comment: column.comment,
              nullable: column.nullable,
              primary_key: column.primary_key
            }
          end
        }
      end
    end
  end
end
