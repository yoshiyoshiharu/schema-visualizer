# frozen_string_literal: true

module Api
  module Tables
    class ColumnsController < ApplicationController
      def index
        table = Table.find(params[:table_id])

        render json: table.columns, only: %i[name type comment]
      end
    end
  end
end
