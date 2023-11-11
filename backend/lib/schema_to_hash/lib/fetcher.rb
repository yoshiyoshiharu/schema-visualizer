# frozen_string_literal: true

require_relative 'fetchers/schema'

class Fetcher
  private attr_reader :db

  def initialize(db:)
    @db = db
  end

  def all_schemas
    Fetchers::Schema.new(db:).all
  end
end
