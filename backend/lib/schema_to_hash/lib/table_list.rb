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
  end
end
