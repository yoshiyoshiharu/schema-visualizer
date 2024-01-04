# frozen_string_literal: true

RSpec.describe Column do
  describe '#name_like' do
    let(:table) { create(:table) }
    let!(:id_include_column1) { create(:column, table:, name: 'id') }
    let!(:id_include_column2) { create(:column, table:, name: 'user_id') }
    let!(:key_include_column) { create(:column, table:, name: 'key') }

    it 'キーワードに一致するレコードを含む' do
      expect(described_class.name_like('id')).to eq [id_include_column1, id_include_column2]
      expect(described_class.name_like('key')).to eq [key_include_column]
    end

    context 'すべてのレコードの名前にキーワードが含まれないとき' do
      it '空の配列を返す' do
        expect(described_class.name_like('hoge')).to eq []
      end
    end
  end
end
