# frozen_string_literal: true

module SchemaToHash
  class Column
    attr_reader :name, :type

    def initialize(name:, type:)
      @name = name
      @type = type
    end
  end
end
