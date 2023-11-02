# frozen_string_literal: true

require 'active_support/inflector'
require_relative '../foreign_key'

module SchemaToHash
  module Scanners
    class ForeignKey
      def initialize(foreign_key_definition:)
        @foreign_key_definition = foreign_key_definition
      end

      def execute
        ::SchemaToHash::ForeignKey.new(
          from_table_name: table_names[:from],
          to_table_name: table_names[:to],
          from_column_name: from_column_name
        )
      end

      private

      def table_names
        match = @foreign_key_definition.match(/add_foreign_key "(.*?)", "(.*?)"/)

        from = match.captures[0]
        to = match.captures[1]

        { from:, to: }
      end

      def from_column_name
        match = @foreign_key_definition.match(/add_foreign_key ".*?", ".*?", column: "(.*?)"/)

        if match
          match.captures[0]
        else
          "#{table_names[:to].singularize}_id"
        end
      end
    end
  end
end
