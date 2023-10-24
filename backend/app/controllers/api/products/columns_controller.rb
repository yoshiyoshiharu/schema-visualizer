# frozen_string_literal: true

class Api::Products::ColumnsController < ApplicationController
  def index
    columns = if params[:name_like].blank?
                Column.none
              else
                Column.name_like(params[:name_like])
              end

    render json: columns, include: :table
  end
end
