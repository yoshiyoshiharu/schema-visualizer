# frozen_string_literal: true

module Batches
  class RelateForeignKeys
    class BatchFailedError < StandardError; end

    def initialize(tables:, foreign_key_hashes:)
      @tables = tables
      @foreign_key_hashes = foreign_key_hashes
    end

    def run
      foreign_key_hashes.each do |foreign_key_hash|
        relate_foreign_key(
          from_column: tables.find_by!(
            name: foreign_key_hash[:from_table_name]
          ).columns.find_by!(name: foreign_key_hash[:from_column_name]),
          to_table: tables.find_by!(name: foreign_key_hash[:to_table_name])
        )
      end
    end

    private

    attr_reader :tables, :foreign_key_hashes

    def relate_foreign_key(from_column:, to_table:)
      # rubocop:disable Rails/Output
      puts "Relating foreign key: #{from_column.name} to #{to_table.name}"
      # rubocop:enable Rails/Output

      from_column.update!(
        foreign_key_table: to_table
      )
    end
  end
end
