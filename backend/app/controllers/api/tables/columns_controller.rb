# frozen_string_literal: true

class Api::Tables::ColumnsController < ApplicationController
  def index
    table = Table.find(params[:table_id])

    render json: table.columns, only: [:name, :type, :comment]
  end
end
