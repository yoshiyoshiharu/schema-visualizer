# frozen_string_literal: true

class ColumnMemo < ApplicationRecord
  belongs_to :column

  def self.content_like(keyword)
    return all if keyword.blank?

    where('column_memos.content LIKE ?', "%#{sanitize_sql_like(keyword)}%")
  end
end
