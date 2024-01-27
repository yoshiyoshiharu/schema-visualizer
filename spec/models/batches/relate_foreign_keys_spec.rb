# frozen_string_literal: true

RSpec.describe Batches::RelateForeignKeys do
  let!(:product) { create(:product) }
  let!(:from_table) { create(:table, name: 'from_table', product:) }
  let!(:to_table) { create(:table, name: 'to_table', product:) }
  let!(:from_column) { create(:column, table: from_table) }

  describe '#run' do
    before do
      foreign_key_hashes = [
        { from_table_name: from_table.name, from_column_name: from_column.name, to_table_name: to_table.name }
      ]

      described_class.new(
        tables: product.tables,
        foreign_key_hashes:
      ).run
    end

    it 'foreign_key_hashesに存在する外部キーを作成する' do
      expect(from_column.reload.foreign_key_table).to eq to_table
    end
  end
end
