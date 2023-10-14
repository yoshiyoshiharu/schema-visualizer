# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :tables, dependent: :destroy
end
