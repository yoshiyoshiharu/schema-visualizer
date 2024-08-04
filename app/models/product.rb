# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :tables, dependent: :delete_all

  validates :name, presence: true, uniqueness: { scope: :env_prefix }
end
