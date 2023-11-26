# frozen_string_literal: true

module Api
  module Columns
    class CommentsController < ApplicationController
      def update
        @column = Column.find(params[:column_id])
        @column_comment = @column.comment || @column.build_comment

        if @column_comment.update(column_comment_params)
          render json: @column_comment
        else
          render json: @column_comment.errors, status: :unprocessable_entity
        end
      end

      private

      def column_comment_params
        params.require(:column_comment).permit(:content)
      end
    end
  end
end
