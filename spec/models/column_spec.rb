# frozen_string_literal: true

RSpec.describe Column do
  describe '#name_like' do
    let(:table) { create(:table) }
    let!(:id_include_column) { create(:column, table:, name: 'id') }
    let!(:not_id_include_column) { create(:column, table:, name: 'name') }

    it 'キーワードに一致するレコードを含む' do
      expect(described_class.name_like('id')).to eq [id_include_column]
    end

    it 'キーワードに一致しないレコードは含まない' do
      expect(described_class.name_like('name')).to eq [not_id_include_column]
    end

    context 'すべてのレコードの名前にキーワードが含まれないとき' do
      it '空の配列を返す' do
        expect(described_class.name_like('hoge')).to eq []
      end
    end
  end
end
