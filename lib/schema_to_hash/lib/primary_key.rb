# frozen_string_literal: true

module SchemaToHash
  class PrimaryKey
    attr_reader :table_name, :column_name

    def initialize(table_name:, column_name:)
      @table_name = table_name
      @column_name = column_name
    end
  end
end
