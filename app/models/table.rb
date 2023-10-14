# frozen_string_literal: true

class Table < ApplicationRecord
  belongs_to :product
  has_many :columns, dependent: :destroy
end
