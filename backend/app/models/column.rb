# frozen_string_literal: true

class Column < ApplicationRecord
  self.inheritance_column = :_type_disabled

  belongs_to :table

  def self.name_like(keyword)
    return all if keyword.blank?

    where('name LIKE ?', "%#{sanitize_sql_like(keyword)}%")
  end
end
