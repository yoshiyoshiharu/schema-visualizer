# frozen_string_literal: true

module SchemaToHash
  class Table
    attr_reader :name, :comment, :columns

    def initialize(name:, comment: nil, columns: [])
      @name = name
      @comment = comment
      @columns = columns
    end

    def to_hash
      {
        name:,
        comment:
      }
    end
  end
end
