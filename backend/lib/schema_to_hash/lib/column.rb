# frozen_string_literal: true

module SchemaToHash
  class Column
    attr_reader :name, :comment, :type, :nullable, :primary_key, :foreign_key_table

    def initialize(name:, type:, comment: '', nullable: true, primary_key: false, foreign_key_table: nil)
      @name = name
      @comment = comment
      @type = type
      @nullable = nullable
      @primary_key = primary_key
      @foreign_key_table = foreign_key_table
    end

    def self.primary_key_id
      new(
        name: 'id',
        type: 'integer',
        comment: 'ID',
        nullable: false,
        primary_key: true,
        foreign_key_table: nil
      )
    end
  end
end
