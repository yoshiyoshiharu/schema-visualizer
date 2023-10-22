# frozen_string_literal: true

class Api::ColumnsController < ApplicationController
  def index
    table = Table.find(params[:table_id])

    render json: table.columns
  end
end
