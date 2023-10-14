# frozen_string_literal: true

class Column < ApplicationRecord
  belongs_to :table
  belongs_to :column_type
end
