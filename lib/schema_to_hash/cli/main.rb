# frozen_string_literal: true

require_relative '../db'
require_relative '../lib/fetcher'

# rubocop:disable Rails/Output
if __FILE__ == $PROGRAM_NAME
  db = Db.connect

  begin
    pp SchemaToHash::Fetcher.new(db:).tables(schema_name: 'public')
  ensure
    db.close
  end
end
# rubocop:enable Rails/Output
