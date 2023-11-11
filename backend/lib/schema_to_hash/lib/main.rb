# frozen_string_literal: true

require_relative 'db'
require_relative 'fetcher'

if __FILE__ == $PROGRAM_NAME
  db = Db.connect

  pp SchemaToHash::Fetcher.new(db:).schemas

  db.close
end
