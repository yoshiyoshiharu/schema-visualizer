# frozen_string_literal: true

class TablesController < ApplicationController
  def index
    raise_routing_error unless turbo_frame_request?

    @products_with_table = fetch_product_with_table
  end

  def show
    unless turbo_frame_request?
      @products_with_table = Product.preload(:tables)
      @products_with_column = Product.none
    end

    @table = Table.preload(columns: %i[memo foreign_key_table]).find(params[:id])
  end

  private

  def fetch_product_with_table
    if params[:name].blank?
      Product.preload(:tables).all
    else
      Product.eager_load(:tables).merge(Table.name_like(params[:name]))
    end
  end
end
