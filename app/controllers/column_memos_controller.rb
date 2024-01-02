# frozen_string_literal: true

class ColumnMemosController < ApplicationController
  def show
    column = Column.find(params[:column_id])
    @column_memo = column.memo || column.build_memo
  end

  def edit
    column = Column.find(params[:column_id])
    @column_memo = column.memo || column.build_memo
  end

  def update
    column = Column.find(params[:column_id])
    @column_memo = column.memo || column.build_memo

    if @column_memo.update(column_memo_params)
      flash.now[:notice] =  t(".success")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def column_memo_params
    params.require(:column_memo).permit(:content)
  end
end
