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

    it 'すべてのレコードの名前にキーワードが含まれない場合空の配列を返す' do
      expect(described_class.name_like('hoge')).to eq []
    end

    it 'キーワードが空の場合すべてのレコードを返す' do
      expect(described_class.name_like('')).to eq [id_include_column1, id_include_column2, key_include_column]
    end
  end

  describe '#comment_like' do
    let(:table) { create(:table) }
    let!(:id_include_column1) { create(:column, table:, name: 'id', comment: 'Id') }
    let!(:id_include_column2) { create(:column, table:, name: 'user_id', comment: 'UserId') }
    let!(:key_include_column) { create(:column, table:, name: 'key', comment: 'Key') }

    it 'キーワードに一致するレコードを含む' do
      expect(described_class.comment_like('Id')).to eq [id_include_column1, id_include_column2]
      expect(described_class.comment_like('Key')).to eq [key_include_column]
    end

    it 'すべてのレコードの名前にキーワードが含まれない場合空の配列を返す' do
      expect(described_class.comment_like('Hoge')).to eq []
    end

    it 'キーワードが空の場合すべてのレコードを返す' do
      expect(described_class.comment_like('')).to eq [id_include_column1, id_include_column2, key_include_column]
    end
  end
end
