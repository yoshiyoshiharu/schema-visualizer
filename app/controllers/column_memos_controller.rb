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
    column = Column.find(params[:column_id])
    @column_memo = column.build_memo

    if @column_memo.update(column_memo_params)
      redirect_to @column_memo
    else
      render :new
    end
  end

  def edit
    column = Column.find(params[:column_id])
    @column_memo = column.memo
  end

  def update
    column = Column.find(params[:column_id])
    @column_memo = column.memo

    if @column_memo.update(column_memo_params)
      redirect_to @column_memo
    else
      render :edit
    end
  end

  private

  def column_memo_params
    params.require(:column_memo).permit(:content)
  end
end
