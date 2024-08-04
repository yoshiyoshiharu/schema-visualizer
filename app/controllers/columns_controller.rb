# frozen_string_literal: true

class ColumnsController < ApplicationController
  def index
    raise_routing_error unless turbo_frame_request?

    @products_with_column = fetch_product_with_column
  end

  private

  # rubocop:disable Metrics/AbcSize
  def fetch_product_with_column
    if params[:name].blank?
      Product.preload(tables: :columns).none
    else
      Product.eager_load(tables: { columns: :memo }).merge(
        Column.name_like(params[:name])
          .or(Column.comment_like(params[:name]))
          .or(ColumnMemo.content_like(params[:name]))
      )
    end
  end
  # rubocop:enable Metrics/AbcSize
end
