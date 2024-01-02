# frozen_string_literal: true

RSpec.describe Column do
  describe '#name_like' do
    before do
      create(:product) do |product|
        create(:table, product:) do |table|
          @column_1 = create(:column, table:, name: 'id')
          @column_2 = create(:column, table:, name: 'user_id')
          @column_3 = create(:column, table:, name: 'name')
        end
      end
    end

    it 'キーワードに一致するレコードを返す' do
      expect(described_class.name_like('id')).to eq [@column_1, @column_2]
    end

    context 'すべてのレコードの名前にキーワードが含まれないとき' do
      it '空の配列を返す' do
        expect(described_class.name_like('hoge')).to eq []
      end
    end
  end
end
