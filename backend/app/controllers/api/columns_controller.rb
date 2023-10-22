# frozen_string_literal: true

class Api::ColumnsController < ApplicationController
  def index
    columns = Column.all
    render json: columns, include: :table
  end
end
