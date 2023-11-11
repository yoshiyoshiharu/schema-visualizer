# frozen_string_literal: true

require_relative 'db'
require_relative 'fetcher'

if __FILE__ == $PROGRAM_NAME
  db = Db.connect

  begin
    pp SchemaToHash::Fetcher.new(db:).execute
  ensure
    db.close
  end
end
