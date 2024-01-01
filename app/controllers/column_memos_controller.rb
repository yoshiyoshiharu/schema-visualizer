# frozen_string_literal: true

class ColumnMemosController < ApplicationController
  def show
    column = Column.find(params[:column_id])
    @column_memo = column.memo || column.build_memo
  end

  def new
    column = Column.find(params[:column_id])
    @column_memo = column.build_memo
  end

  def create
  end

  def edit
    column = Column.find(params[:column_id])
    @column_memo = column.memo
  end

  def update
  end
end
