# frozen_string_literal: true

class TablesController < ApplicationController
  def show
    unless turbo_frame_request?
      @products_with_table = Product.preload(:tables)
      @products_with_column = Product.none
    end

    @table = Table.preload(columns: %i[memo foreign_key_table]).find(params[:id])
  end
end
