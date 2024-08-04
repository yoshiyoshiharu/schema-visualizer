# frozen_string_literal: true

RSpec.describe SchemaToHash::FetcherFactory do
  describe '.call' do
    let(:db_mock) { double }

    context 'adapterがmysqlの場合' do
      it 'MysqlFetcherインスタンスを返す' do
        allow(db_mock).to receive(:adapter).and_return('mysql')
        expect(described_class.call(db: db_mock)).to be_a(SchemaToHash::MysqlFetcher)
      end
    end

    context 'adapterがpostgresqlの場合' do
      it 'PostgresqlFetcherインスタンスを返す' do
        allow(db_mock).to receive(:adapter).and_return('postgresql')
        expect(described_class.call(db: db_mock)).to be_a(SchemaToHash::PostgresqlFetcher)
      end
    end

    context 'adapterがmysqlまたはpostgresql以外の場合' do
      it 'ArgumentErrorを発生させる' do
        allow(db_mock).to receive(:adapter).and_return('sqlite3')
        expect { described_class.call(db: db_mock) }.to raise_error(ArgumentError)
      end
    end
  end
end
