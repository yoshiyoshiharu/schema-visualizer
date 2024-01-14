# frozen_string_literal: true

require 'pg'

module SchemaToHash
  class Db
    def self.connect(dbname:, user:, password:, host:, port:)
      PG.connect(
        dbname:,
        user:,
        password:,
        host:,
        port:
      )
    end
  end
end
