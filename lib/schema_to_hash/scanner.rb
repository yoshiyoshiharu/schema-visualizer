# frozen_string_literal: true

require_relative 'table'
require_relative 'table_list'
require_relative 'column'
require_relative 'type'

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
          table: table.name,
          columns: table.columns.map do |column|
            {
              name: column.name,
              type: column.type
            }
          end
        }
      end
    end

    def generate_table_list
      @schema_text.each_line do |line|
        if start_table_definition?(line)
          @table = Table.new(name: table_name(line))
        elsif start_columm_definition?(line)
          @table.add_column(Column.new(**column(line))) if column(line).is_a?(Hash)
        elsif end_table_definition?(line)
          @table_list.add(@table)
          @table = nil
        end
      end

      self
    end

    private

    def start_table_definition?(line)
      line.strip.start_with?('create_table')
    end

    def end_table_definition?(line)
      @table && line.strip.start_with?('end')
    end

    def table_name(line)
      match = line.match(/create_table "(.*?)"/)
      if match
        match.captures[0]
      else
        nil
      end
    end

    def start_columm_definition?(line)
      @table && line.strip.start_with?('t.')
    end

    def column(line)
      match = line.match(/t\.(\w+) "(.*?)"/)

      type, name = nil
      if match
        type = match.captures[0]
        name = match.captures[1]
      end

      if TYPE.include?(type)
        { type: type, name: name }
      else
        nil
      end
    end
  end
end
