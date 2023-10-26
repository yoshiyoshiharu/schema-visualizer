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
          if index == 0
            @table = ::SchemaToHash::Table.new(name: name(line), comment: comment(line))
            @table.add_column(SchemaToHash::Column.primary_key_id) if primary_key_id?(line)
            next
          end

          if start_columm_definition?(line)
            @table.add_column(Scanners::Column.new(line).execute)
          end
        end

        @table
      end

      private

      def name(line)
        match = line.match(/create_table "(.*?)"/)
        if match
          match.captures[0]
        else
          raise 'Table name not found'
        end
      end

      def comment(line)
        match = line.match(/comment: "(.*?)"/)
        if match
          match.captures[0]
        else
          nil
        end
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
