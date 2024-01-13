# frozen_string_literal: true

require_relative '../../../lib/schema_to_hash/schema_to_hash'

RSpec.describe SchemaToHash::Fetcher do
  let(:connection_config_hash) { ActiveRecord::Base.connection_db_config.configuration_hash }
  let(:db) do
    SchemaToHash::Db.connect(
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
      ActiveRecord::Base.connection.create_schema('test_schema1')
      ActiveRecord::Base.connection.create_schema('test_schema2')
      ActiveRecord::Base.connection.create_schema('test_schema3')

      pp ActiveRecord::Base.connection.schema_names
    end
  end
end
