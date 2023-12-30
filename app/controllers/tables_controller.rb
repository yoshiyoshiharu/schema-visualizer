# frozen_string_literal: true

class TablesController < ApplicationController
  def show
    @table = Table.find(params[:id])
  end
end
