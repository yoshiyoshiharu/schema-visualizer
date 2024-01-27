# frozen_string_literal: true

module Batches
  class CreateAndDestroyTables
    class BatchFailedError < StandardError; end

    def initialize(existing_tables:, latest_table_hashes:, product:)
      @existing_tables = existing_tables
      @latest_table_hashes = latest_table_hashes
      @product = product
    end

    def run
      create_tables(table_hashes_to_create)
    end

    private

    attr_reader :existing_tables, :latest_table_hashes, :product

    def table_hashes_to_create
      latest_table_hashes.select do |table_hash|
        existing_tables.none? { |table| table.name == table_hash[:name] }
      end
    end

    def tables_to_delete
      existing_tables.select do |table|
        latest_table_hashes.none? { |table_hash| table_hash[:name] == table.name }
      end
    end

    def create_tables(tables_hash)
      tables_hash.each do |table_hash|
        # rubocop:disable Rails/Output
        puts "Creating table: #{table_hash[:name]}"
        # rubocop:enable Rails/Output

        product.tables.create!(
          name: table_hash[:name],
          comment: table_hash[:comment] || ''
        )
      end
    end

    def destroy_tables(tables_to_delete)
      return if tables_to_delete.blank?

      # rubocop:disable Rails/Output
      puts "Destroying tables #{tables_to_delete.pluck(:name)}"
      # rubocop:enable Rails/Output
      Table.where(id: tables_to_delete.pluck(:id)).destroy_all
    end
  end
end
