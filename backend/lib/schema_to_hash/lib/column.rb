# frozen_string_literal: true

module SchemaToHash
  class Column
    attr_reader :name, :comment, :type, :nullable

    def initialize(name:, comment:, type:, nullable:)
      @name = name
      @comment = comment
      @type = type
      @nullable = nullable
    end
  end
end
