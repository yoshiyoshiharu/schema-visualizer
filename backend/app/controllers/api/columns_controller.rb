# frozen_string_literal: true

class Api::ColumnsController < ApplicationController
  def index
    table = Table.find_by(id: params[:table_id])

    if table.nil?
      return render json: { error: '404 error' }, status: 404
    end

    columns = table.columns
    render json: columns
  end
end
