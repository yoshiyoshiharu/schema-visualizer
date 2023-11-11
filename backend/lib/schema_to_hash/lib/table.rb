# frozen_string_literal: true

module SchemaToHash
  class Table
    attr_reader :name, :comment, :columns

    def initialize(name:, comment: nil, columns: [])
      @name = name
      @comment = comment
      @columns = columns
    end

    def add_column(column)
      @columns << column
    end

    def find_column_by_name(name)
      @columns.find { |column| column.name == name }
    end

    def to_hash
      {
        name:,
        comment:,
        columns: columns.map(&:to_hash)
      }
    end
  end
end
