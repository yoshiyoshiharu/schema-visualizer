# frozen_string_literal: true

module SchemaToHash
  class ForeignKey
    attr_reader :from_table_name, :to_table_name, :from_column_name

    def initialize(from_table_name: nil, to_table_name: nil, from_column_name: nil)
      @from_table_name = from_table_name
      @to_table_name = to_table_name
      @from_column_name = from_column_name
    end

    def to_hash
      {
        from_table_name:,
        to_table_name:,
        from_column_name:
      }
    end
  end
end
