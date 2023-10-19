# frozen_string_literal: true

class Api::TablesController < ApplicationController
  def index
    tables = Table.all
    render json: tables
  end
end
