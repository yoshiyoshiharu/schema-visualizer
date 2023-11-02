# frozen_string_literal: true

class Column < ApplicationRecord
  self.inheritance_column = :_type_disabled

  belongs_to :table
  belongs_to :foreign_key_table,
             class_name: 'Table',
             foreign_key: 'foreign_key_table_id',
             optional: true,
             inverse_of: 'columns'

  def self.name_like(keyword)
    return all if keyword.blank?

    where('columns.name LIKE ?', "%#{sanitize_sql_like(keyword)}%")
  end
end
