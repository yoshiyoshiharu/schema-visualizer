# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products_with_table = fetch_product_with_table
    @products_with_column = fetch_product_with_column
  end

  private

  def fetch_product_with_table
    if params[:name].blank?
      Product.preload(:tables).all
    else
      Product.eager_load(:tables).merge(Table.name_like(params[:name]))
    end
  end

  def fetch_product_with_column
    if params[:name].blank?
      Product.preload(tables: :columns).all
    else
      Product.eager_load(tables: :columns).merge(Column.name_like(params[:name]))
    end
  end
end
