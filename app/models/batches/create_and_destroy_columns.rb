# frozen_string_literal: true

module Batches
  class CreateAndDestroyColumns
    def initialize(existing_columns:, latest_column_hashes:, table:)
      @existing_columns = existing_columns
      @latest_column_hashes = latest_column_hashes
      @table = table
    end

    def run
      destroy_columns(columns_to_delete)
      create_column(column_hashes_to_create)
    end

    private

    attr_reader :existing_columns, :latest_column_hashes, :table

    def column_hashes_to_create
      latest_column_hashes.select do |column_hash|
        existing_columns.none? { |column| column.name == column_hash[:name] }
      end
    end

    def columns_to_delete
      existing_columns.select do |column|
        latest_column_hashes.none? { |column_hash| column_hash[:name] == column.name }
      end
    end

    def create_column(column_hashes)
      columns = column_hashes.map do |column_hash|
        {
          name: column_hash[:name],
          type: column_hash[:type],
          comment: column_hash[:comment] || '',
          nullable: column_hash[:nullable],
          primary_key: column_hash[:primary_key]
        }
      end

      table.columns.insert_all!(columns, record_timestamps: true) # rubocop:disable Rails/SkipsModelValidations
    end

    def destroy_columns(columns_to_delete)
      return if columns_to_delete.blank?

      Column.where(id: columns_to_delete.pluck(:id)).destroy_all
    end
  end
end
