# frozen_string_literal: true

class ColumnMemosController < ApplicationController
  before_action :reject_not_turbo_request

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
      flash.now[:notice] = t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def reject_not_turbo_request
    raise_routing_error unless turbo_frame_request?
  end

  def column_memo_params
    params.require(:column_memo).permit(:content)
  end
end
