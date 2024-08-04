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

    it 'すべてのレコードの名前にキーワードが含まれない場合空の配列を返す' do
      expect(described_class.name_like('hoge')).to eq []
    end

    it 'キーワードが空の場合すべてのレコードを返す' do
      expect(described_class.name_like('')).to eq [user_include_table1, user_include_table2, book_include_table]
    end
  end

  describe '#comment_like' do
    let(:product) { create(:product) }
    let!(:user_include_table1) { create(:table, product:, name: 'users', comment: 'ユーザー') }
    let!(:user_include_table2) { create(:table, product:, name: 'user_profiles', comment: 'ユーザープロフィール') }
    let!(:book_include_table) { create(:table, product:, name: 'books', comment: '本') }

    it 'コメントがキーワードに一致するレコードを含む' do
      expect(described_class.comment_like('ユーザー')).to eq [user_include_table1, user_include_table2]
      expect(described_class.comment_like('本')).to eq [book_include_table]
    end

    it 'すべてのレコードのコメントにキーワードが含まれない場合空の配列を返す' do
      expect(described_class.comment_like('hoge')).to eq []
    end

    it 'キーワードが空の場合すべてのレコードを返す' do
      expect(described_class.comment_like('')).to eq [user_include_table1, user_include_table2, book_include_table]
    end
  end
end
