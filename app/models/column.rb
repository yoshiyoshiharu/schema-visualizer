# frozen_string_literal: true

class Column < ApplicationRecord
  self.inheritance_column = :_type_disabled

  belongs_to :table
end
