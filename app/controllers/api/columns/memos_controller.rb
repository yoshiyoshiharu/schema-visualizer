# frozen_string_literal: true

module Api
  module Columns
    class MemosController < ApplicationController
      def update
        @column = Column.find(params[:column_id])
        @column_memo = @column.memo || @column.build_memo

        if @column_memo.update(column_memo_params)
          render json: @column_memo
        else
          render json: @column_memo.errors, status: :unprocessable_entity
        end
      end

      private

      def column_memo_params
        params.require(:column_memo).permit(:content)
      end
    end
  end
end
