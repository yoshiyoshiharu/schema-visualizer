# frozen_string_literal: true

module ApplicationHelper
  def new_or_edit_column_memo_path(column_memo)
    raise ArgumentError, 'Column model must be persisted' unless column_memo.column&.persisted?

    if column_memo.persisted?
      edit_column_memo_path([column_memo.column, column_memo])
    else
      new_column_memo_path(column_memo.column, column_memo)
    end
  end

  def display_nullable(boolean)
    boolean ? '◯' : '✕'
  end
end
