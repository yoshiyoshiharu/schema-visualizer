# frozen_string_literal: true

RSpec.describe SchemaToHash::MysqlFetcher do
  let(:db) do
    SchemaToHash::Db.new(
      database_url: ENV.fetch('TEST_MYSQL_DATABASE_URL')
    )
  end
  let!(:fetcher) { SchemaToHash::FetcherFactory.call(db:) }

  describe '#schemas' do
    it 'DB一覧を取得すること' do
      test_schema(db) do
        expect(fetcher.schemas).to eq %w[test schema_to_hash_test]
      end
    end
  end

  # rubocop:disable RSpec/ExampleLength
  describe '#tables' do
    it 'DBのテーブル名一覧を取得すること' do
      test_schema(db) do
        db.exec('CREATE TABLE users (id INT);')
        db.exec('CREATE TABLE profiles (id INT);')

        expect(
          fetcher.tables(schema_name: test_schema_name).pluck(:name).sort
        ).to eq %w[users profiles].sort
      end
    end

    it 'DBのテーブルコメントを取得すること' do
      test_schema(db) do
        db.exec("CREATE TABLE users (id INT) COMMENT 'ユーザー';")

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
              id INT,
              name VARCHAR(255),
              created_at TIMESTAMP,
              updated_at TIMESTAMP
            );
          SQL
        )

        expect(
          fetcher.columns(schema_name: test_schema_name, table_name: 'users').pluck(:name)
        ).to eq %w[id name created_at updated_at]
      end
    end
  end

  describe '#foreign_keys' do
    it 'DBの外部キー一覧を取得すること' do
      test_schema(db) do
        db.exec('CREATE TABLE users (id INT PRIMARY KEY);')
        db.exec('CREATE TABLE profiles (id INT PRIMARY KEY, user_id INT);')
        db.exec(
          <<-SQL.squish
            ALTER TABLE profiles ADD CONSTRAINT profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES users (id);
          SQL
        )

        expect(
          fetcher.foreign_keys(schema_name: test_schema_name).pluck(
            :from_table_name,
            :from_column_name,
            :to_table_name
          ).flatten
        ).to eq %w[profiles user_id users]
      end
    end
  end

  private

  def test_schema(db)
    db.exec("CREATE DATABASE IF NOT EXISTS #{test_schema_name}")
    db.exec("USE #{test_schema_name}")

    begin
      yield
    ensure
      db.exec("DROP DATABASE #{test_schema_name}")
    end
  end

  def test_schema_name
    'schema_to_hash_test'
  end
  # rubocop:enable RSpec/ExampleLength
end
