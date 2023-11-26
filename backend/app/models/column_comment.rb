# frozen_string_literal: true

class ColumnComment < ApplicationRecord
  belongs_to :column

  validates :content, presence: true
end
