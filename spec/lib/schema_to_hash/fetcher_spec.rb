# frozen_string_literal: true

require_relative '../../../lib/schema_to_hash/schema_to_hash'

RSpec.describe SchemaToHash::Fetcher do
  let(:connection_config_hash) { ActiveRecord::Base.connection_db_config.configuration_hash }
  let(:db) do
    PG.connect(
      dbname: connection_config_hash[:database],
      user: connection_config_hash[:username],
      password: connection_config_hash[:password],
      host: connection_config_hash[:host],
      port: connection_config_hash[:port]
    )
  end
  let!(:fetcher) { described_class.new(db:) }

  describe '#schemas' do
    it 'DBのスキーマ一覧を取得すること' do
      test_schema(db) do
        expect(fetcher.schemas).to eq %w[public schema_to_hash_test]
      end
    end
  end

  describe '#tables' do
    it 'スキーマのテーブル名一覧を取得すること' do
      test_schema(db) do
        db.exec(
          <<-SQL.squish
            CREATE TABLE users (id integer);
            CREATE TABLE profiles (id integer);
          SQL
        )

        expect(
          fetcher.tables(schema_name: test_schema_name).pluck(:name)
        ).to eq %w[users profiles]
      end
    end

    it 'スキーマのテーブルコメントを取得すること' do
      test_schema(db) do
        db.exec(
          <<-SQL.squish
            CREATE TABLE users (id integer);
            COMMENT ON TABLE users IS 'ユーザー';
          SQL
        )

        expect(
          fetcher.tables(schema_name: test_schema_name).pluck(:comment)
        ).to eq ['ユーザー']
      end
    end
  end

  describe '#columns' do
    it 'テーブルのカラム一覧を取得すること' do
      test_schema(db) do
        db.exec(
          <<-SQL.squish
            CREATE TABLE users (
              id integer,
              name varchar(255),
              created_at timestamp without time zone,
              updated_at timestamp without time zone
            );
          SQL
        )

        expect(
          fetcher.columns(schema_name: test_schema_name, table_name: 'users').pluck(:name)
        ).to eq %w[id name created_at updated_at]
      end
    end 
  end

  private

  def test_schema(db)
    db.exec("CREATE SCHEMA IF NOT EXISTS #{test_schema_name}")
    db.exec("SET search_path TO #{test_schema_name}")

    begin
      yield
    ensure
      db.exec("DROP SCHEMA #{test_schema_name} CASCADE")
    end
  end

  def test_schema_name
    'schema_to_hash_test'
  end
end
