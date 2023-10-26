# frozen_string_literal: true

require_relative '../table'
require_relative '../column'
require_relative '../type'
require_relative 'column'

module SchemaToHash
  module Scanners
    class Table
      def initialize(table_definition)
        @table_definition = table_definition
        @table = nil
      end

      def execute
        @table_definition.each_line.with_index do |line, index|
          if index.zero?
            @table = ::SchemaToHash::Table.new(name: name(line), comment: comment(line))
            @table.add_column(SchemaToHash::Column.primary_key_id) if primary_key_id?(line)
            next
          end

          @table.add_column(Scanners::Column.new(line).execute) if start_columm_definition?(line)
        end

        @table
      end

      private

      def name(line)
        match = line.match(/create_table "(.*?)"/)
        raise 'Table name not found' unless match

        match.captures[0]
      end

      def comment(line)
        match = line.match(/comment: "(.*?)"/)

        match.captures[0] if match
      end

      def start_columm_definition?(line)
        match = line.strip.match(/t\.(\w+)/)

        @table && match && TYPE.include?(match.captures[0])
      end

      def primary_key_id?(line)
        !line.strip.include?('id: false')
      end
    end
  end
end
