# frozen_string_literal: true

require 'pg'

class Db
  def self.connect
    PG.connect(
      dbname: 'myapp_development',
      user: 'postgres',
      password: 'postgres',
      host: 'db',
      port: '5432'
    )
  end
end
