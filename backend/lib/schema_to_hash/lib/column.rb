# frozen_string_literal: true

module SchemaToHash
  class Column
    attr_reader :name, :comment, :type, :nullable, :primary_key
    attr_accessor :foreign_key_table

    def initialize(name:, type:, comment: '', nullable: true, primary_key: false)
      @name = name
      @comment = comment
      @type = type
      @nullable = nullable
      @primary_key = primary_key
    end

    def self.primary_key_id
      new(
        name: 'id',
        type: 'integer',
        comment: 'ID',
        nullable: false,
        primary_key: true,
      )
    end
  end
end
