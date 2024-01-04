# frozen_string_literal: true

RSpec.describe Table do
  describe '#name_like' do
    let(:product) { create(:product) }
    let!(:user_include_table1) { create(:table, product:, name: 'users') }
    let!(:user_include_table2) { create(:table, product:, name: 'user_profiles') }
    let!(:book_include_table) { create(:table, product:, name: 'books') }

    it 'キーワードに一致するレコードを含む' do
      expect(described_class.name_like('user')).to eq [user_include_table1, user_include_table2]
      expect(described_class.name_like('book')).to eq [book_include_table]
    end

    context 'すべてのレコードの名前にキーワードが含まれないとき' do
      it '空の配列を返す' do
        expect(described_class.name_like('hoge')).to eq []
      end
    end
  end
end
