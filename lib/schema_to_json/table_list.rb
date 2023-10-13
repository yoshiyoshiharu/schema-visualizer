# frozen_string_literal: true

class TableList
  attr_reader :tables

  def initialize(tables = [])
    @tables = tables
  end

  def add(table)
    @tables << table
  end
end
