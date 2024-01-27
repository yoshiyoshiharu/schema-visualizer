# frozen_string_literal: true

RSpec.describe Batches::CreateAndDestroyTables do
  let(:product) { create(:product) }

  describe '#run' do
    context 'existing_tablesに存在し、latest_table_hashesに存在しないテーブルがあるとき' do
      before do
        create(:table, name: 'table1', product:)
        create(:table, name: 'table2', product:)
        create(:table, name: 'table3', product:)

        latest_table_hashes = [
          { name: 'table1', comment: 'table1 comment' },
          { name: 'table2', comment: 'table2 comment' }
        ]

        described_class.new(
          existing_tables: product.tables,
          latest_table_hashes:,
          product:
        ).run
      end

      it 'latest_table_hashesに存在しないテーブルを削除する' do
        expect(product.tables.reload.pluck(:name)).to eq %w[table1 table2]
      end
    end

    context 'existing_tablesに存在せず、latest_table_hashesに存在するテーブルがあるとき' do
      before do
        create(:table, name: 'table1', product:)
        create(:table, name: 'table2', product:)

        latest_table_hashes = [
          { name: 'table1', comment: 'table1 comment' },
          { name: 'table2', comment: 'table2 comment' },
          { name: 'table3', comment: 'table3 comment' }
        ]

        described_class.new(
          existing_tables: product.tables,
          latest_table_hashes:,
          product:
        ).run
      end

      it 'latest_table_hashesに存在するテーブルを作成する' do
        expect(product.tables.reload.pluck(:name)).to eq %w[table1 table2 table3]
      end
    end
  end
end
