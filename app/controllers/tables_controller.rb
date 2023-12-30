# frozen_string_literal: true

class TablesController < ApplicationController
  def show
    @products = Product.all.preload(:tables)
    @table = Table.find(params[:id])
  end
end
