# frozen_string_literal: true

require_relative 'table_list'
require_relative 'foreign_key_list'
require_relative 'scanners/table'
require_relative 'scanners/foreign_key'

module SchemaToHash
  class Scanner
    def initialize(schema_text)
      @table_list = TableList.new
      @foreign_key_list = ForeignKeyList.new
      @table = nil
      @schema_text = schema_text
    end

    def to_hash
      {
        tables: @table_list.to_hash,
        foreign_keys: @foreign_key_list.to_hash
      }
    end

    def execute
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

        if start_foreign_key_definition?(line)
          @foreign_key_list.add(Scanners::ForeignKey.new(foreign_key_definition: line).execute)
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

    def start_foreign_key_definition?(line)
      line.strip.start_with?('add_foreign_key')
    end
  end
end
