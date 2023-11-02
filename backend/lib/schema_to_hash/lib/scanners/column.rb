# frozen_string_literal: true

module SchemaToHash
  module Scanners
    class Column
      def initialize(column_definition)
        @column_definition = column_definition
      end

      def execute
        ::SchemaToHash::Column.new(**type_name, comment:, nullable:)
      end

      private

      def type_name
        match = @column_definition.match(/t\.(\w+) "(.*?)"/)

        type = match.captures[0]
        name = match.captures[1]

        { type:, name: }
      end

      def comment
        match = @column_definition.match(/comment: "(.*?)"/)
        match.captures[0] if match
      end

      def nullable
        match = @column_definition.match(/null: (.*?),/)
        if match
          match.captures[0]
        else
          true
        end
      end
    end
  end
end
