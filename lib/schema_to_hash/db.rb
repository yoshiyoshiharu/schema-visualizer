# frozen_string_literal: true

module SchemaToHash
  class Db
    attr_reader :adapter

    # rubocop:disable Metrics/MethodLength
    def initialize(database_url:, postgres_schema: nil)
      @database_url = database_url
      @postgres_schema = postgres_schema
      parse_database_url
      @client = case adapter
                when 'mysql'
                  Mysql2::Client.new(host:, port:, username: user, password:, database:)
                when 'postgresql'
                  PG.connect(host:, port:, user:, password:, dbname: database)
                else
                  raise ArgumentError, "Unsupported adapter: #{adapter}"
                end
    end
    # rubocop:enable Metrics/MethodLength

    def exec(sql)
      case client
      when Mysql2::Client
        client.query(sql)
      when PG::Connection
        client.exec(sql)
      end
    end

    def parse_database_url
      uri = URI.parse(database_url)
      @adapter = uri.scheme
      @host = uri.host
      @port = uri.port
      @user = uri.user
      @password = uri.password
      @database = uri.path.delete('/')
    end

    def schema
      case adapter
      when 'mysql'
        database
      when 'postgresql'
        @postgres_schema
      end
    end

    private

    attr_reader :client, :database_url, :host, :port, :user, :password, :database
  end
end
