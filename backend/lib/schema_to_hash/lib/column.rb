# frozen_string_literal: true

module SchemaToHash
  class Column
    attr_reader :name, :comment, :type

    def initialize(name:, comment:, type:)
      @name = name
      @comment = comment
      @type = type
    end
  end
end
