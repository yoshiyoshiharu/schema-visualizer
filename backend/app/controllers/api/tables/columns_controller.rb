# frozen_string_literal: true

module Api
  module Tables
    class ColumnsController < ApplicationController
      def index
        table = Table.find(params[:table_id])

        render json: table.columns,
               include: { foreign_key_table: { only: %i[id name] } },
               only: %i[name type comment nullable primary_key]
      end
    end
  end
end
