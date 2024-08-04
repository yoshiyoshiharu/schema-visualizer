# frozen_string_literal: true

RSpec.describe Batches::CreateAndDestroyColumns do
  let(:table) { create(:table) }

  describe '#run' do
    context 'existing_columnsに存在し、latest_column_hashesに存在しないテーブルがある場合' do
      before do
        create(:column, name: 'column1', table:)
        create(:column, name: 'column2', table:)
        create(:column, name: 'column3', table:)

        latest_column_hashes = [
          { name: 'column1', type: 'integer', nullable: true, primary_key: false, comment: 'column1 comment' },
          { name: 'column2', type: 'integer', nullable: true, primary_key: false, comment: 'column2 comment' }
        ]

        described_class.new(
          existing_columns: table.columns,
          latest_column_hashes:,
          table:
        ).run
      end

      it 'latest_column_hashesに存在しないテーブルを削除する' do
        expect(table.columns.reload.pluck(:name)).to eq %w[column1 column2]
      end
    end

    context 'existing_columnsに存在せず、latest_column_hashesに存在するテーブルがある場合' do
      before do
        create(:column, name: 'column1', table:)
        create(:column, name: 'column2', table:)

        latest_column_hashes = [
          { name: 'column1', type: 'integer', nullable: true, primary_key: false, comment: 'column1 comment' },
          { name: 'column2', type: 'integer', nullable: true, primary_key: false, comment: 'column2 comment' },
          { name: 'column3', type: 'integer', nullable: true, primary_key: false, comment: 'column3 comment' }
        ]

        described_class.new(
          existing_columns: table.columns,
          latest_column_hashes:,
          table:
        ).run
      end

      it 'latest_column_hashesに存在するテーブルを作成する' do
        expect(table.columns.reload.pluck(:name)).to eq %w[column1 column2 column3]
      end
    end
  end
end
