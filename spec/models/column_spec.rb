# frozen_string_literal: true

RSpec.describe Column do
  describe '#name_like' do
    let!(:table) { create(:table) }
    let!(:column1) { create(:column, table: table, name: 'id') }
    let!(:column2) { create(:column, table: table, name: 'user_id') }
    let!(:column3) { create(:column, table: table, name: 'name') }

    it 'キーワードに一致するレコードを返す' do
      expect(described_class.name_like('id')).to eq [column1, column2]
    end

    context 'すべてのレコードの名前にキーワードが含まれないとき' do
      it '空の配列を返す' do
        expect(described_class.name_like('hoge')).to eq []
      end
    end
  end
end
