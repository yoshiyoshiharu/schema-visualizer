# frozen_string_literal: true

module SchemaToHash
  class FetcherFactory
    def self.call(db:)
      case db.adapter
      when 'mysql'
        SchemaToHash::MysqlFetcher.new(db:)
      when 'postgresql'
        SchemaToHash::PostgresqlFetcher.new(db:)
      else
        raise ArgumentError, "Unsupported adapter: #{db.adapter}"
      end
    end
  end
end
