# frozen_string_literal: true

class Column < ApplicationRecord
  self.inheritance_column = :_type_disabled

  belongs_to :table
  belongs_to :foreign_key_table,
             class_name: 'Table',
             optional: true
  has_one :memo,
          dependent: :destroy,
          class_name: 'ColumnMemo'

  def self.name_like(keyword)
    return all if keyword.blank?

    where('columns.name LIKE ?', "%#{sanitize_sql_like(keyword)}%")
  end
end
