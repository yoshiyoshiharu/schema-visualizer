# frozen_string_literal: true

module SchemaToHash
  class ForeignKeyList
    attr_reader :foreign_keys

    def initialize(foreign_keys = [])
      @foreign_keys = foreign_keys
    end

    def add(foreign_key)
      @foreign_keys << foreign_key
    end

    def to_hash
      foreign_keys.map do |foreign_key|
        {
          from_table_name: foreign_key.from_table_name,
          to_table_name: foreign_key.to_table_name,
          from_column_name: foreign_key.from_column_name
        }
      end
    end
  end
end
