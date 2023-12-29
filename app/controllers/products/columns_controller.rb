# frozen_string_literal: true

module Products
  class ColumnsController < ApplicationController
    def index
      @columns = if params[:name_like].blank?
                   Product.none
                 else
                   Product.eager_load(tables: :columns)
                          .merge(Column.name_like(params[:name_like]))
                 end
    end
  end
end
