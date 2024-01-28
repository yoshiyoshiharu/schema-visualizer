# frozen_string_literal: true

class ColumnsController < ApplicationController
  def index
    raise_routing_error unless turbo_frame_request?

    @products_with_column = fetch_product_with_column
  end

  private

  def fetch_product_with_column
    if params[:name].blank?
      Product.preload(tables: :columns).none
    else
      Product.eager_load(tables: :columns).merge(Column.name_like(params[:name]))
    end
  end
end
