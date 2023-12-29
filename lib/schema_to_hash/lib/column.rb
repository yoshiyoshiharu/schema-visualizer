# frozen_string_literal: true

module SchemaToHash
  class Column
    attr_reader :name, :comment, :type, :nullable, :default, :primary_key

    # rubocop:disable Metrics/ParameterLists
    def initialize(name:, type:, comment: '', nullable: true, default: nil, primary_key: false)
      @name = name
      @comment = comment
      @type = type
      @nullable = nullable
      @default = default
      @primary_key = primary_key
    end
    # rubocop:enable Metrics/ParameterLists

    def to_hash
      {
        name:,
        comment:,
        type:,
        nullable:,
        default:,
        primary_key:
      }
    end
  end
end
