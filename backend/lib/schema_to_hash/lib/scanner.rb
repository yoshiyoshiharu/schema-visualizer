# frozen_string_literal: true

require_relative 'table_list'
require_relative 'scanners/table'

module SchemaToHash
  class Scanner
    def initialize(schema_text)
      @table_list = TableList.new
      @table = nil
      @schema_text = schema_text
    end

    def to_hash
      @table_list.tables.map do |table|
        {
          name: table.name,
          comment: table.comment,
          columns: table.columns.map do |column|
            {
              name: column.name,
              type: column.type,
              comment: column.comment,
              nullable: column.nullable
            }
          end
        }
      end
    end

    def generate_table_list
      table_definition = ''

      @schema_text.each_line do |line|
        if start_table_definition?(line)
          table_definition += line
        elsif !table_definition.empty? && end_table_definition?(line)
          table_definition += line
          table = Scanners::Table.new(table_definition).execute
          @table_list.add(table)
          table_definition = ''
        elsif !table_definition.empty?
          table_definition += line
        end
      end

      self
    end

    private

    def start_table_definition?(line)
      line.strip.start_with?('create_table')
    end

    def end_table_definition?(line)
      line.strip.start_with?('end')
    end
  end
end
