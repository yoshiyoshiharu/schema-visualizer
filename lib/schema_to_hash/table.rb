# frozen_string_literal: true

module SchemaToHash
  class Table
    attr_reader :name, :columns

    def initialize(name:, columns: [])
      @name = name
      @columns = columns
    end

    def add_column(column)
      @columns << column
    end
  end
end
