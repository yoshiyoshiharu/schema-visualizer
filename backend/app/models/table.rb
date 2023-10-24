# frozen_string_literal: true

class Table < ApplicationRecord
  belongs_to :product
  has_many :columns, dependent: :destroy

  def self.name_like(keyword)
    return all if keyword.blank?

    where('tables.name LIKE ?', "%#{sanitize_sql_like(keyword)}%")
  end
end
