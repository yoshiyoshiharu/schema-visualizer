# frozen_string_literal: true

class ColumnMemo < ApplicationRecord
  belongs_to :column

  validates :content, presence: true
end
