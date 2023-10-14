# frozen_string_literal: true

class ColumnType < ApplicationRecord
  has_many :columms, dependent: :destroy
end
