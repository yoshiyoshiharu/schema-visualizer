# frozen_string_literal: true

require 'pg'

conn = PG.connect(dbname: 'myapp_development', user: 'postgres', password: 'postgres', host: 'db', port: '5432')
conn.exec("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';") do |result|
  result.each do |row|
    pp row
  end
end
