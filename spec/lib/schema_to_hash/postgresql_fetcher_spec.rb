# frozen_string_literal: true

RSpec.describe SchemaToHash::PostgresqlFetcher do
  let(:db) do
    SchemaToHash::Db.new(
      database_url: ENV.fetch('TEST_POSTGRESQL_DATABASE_URL')
    )
  end
  let!(:fetcher) { SchemaToHash::FetcherFactory.call(db:) }

  describe '#schemas' do
    it 'DBのスキーマ一覧を取得すること' do
      test_schema(db) do
        expect(fetcher.schemas).to eq %w[public schema_to_hash_test]
      end
    end
  end

  # rubocop:disable RSpec/ExampleLength
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

  describe '#foreign_keys' do
    it 'DBの外部キー一覧を取得すること' do
      test_schema(db) do
        db.exec(
          <<-SQL.squish
            CREATE TABLE users (
              id integer PRIMARY KEY
            );
            CREATE TABLE profiles (
              id integer PRIMARY KEY,
              user_id integer
            );
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
  # rubocop:enable RSpec/ExampleLength

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
