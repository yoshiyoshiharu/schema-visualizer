# frozen_string_literal: true

RSpec.describe ColumnMemo do
  describe '#content_like' do
    let(:table) { create(:table) }
    let!(:id_include_column_memo1) do
      create(:column_memo, column: create(:column, table:, name: 'id'), content: 'id')
    end
    let!(:id_include_column_memo2) do
      create(:column_memo, column: create(:column, table:, name: 'user_id'), content: 'user_id')
    end
    let!(:key_include_column_memo) do
      create(:column_memo, column: create(:column, table:, name: 'key'), content: 'key')
    end

    it '内容がキーワードに一致するレコードを含む' do
      expect(described_class.content_like('id')).to eq [id_include_column_memo1, id_include_column_memo2]
      expect(described_class.content_like('key')).to eq [key_include_column_memo]
    end

    it 'すべてのレコードの内容にキーワードが含まれない場合空の配列を返す' do
      expect(described_class.content_like('hoge')).to eq []
    end

    it 'キーワードが空の場合すべてのレコードを返す' do
      expect(described_class.content_like('')).to eq [
        id_include_column_memo1,
        id_include_column_memo2,
        key_include_column_memo
      ]
    end
  end
end
